package com.group.exam.member.controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.group.exam.member.command.InsertCommand;
import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.command.NaverLoginBO;
import com.group.exam.member.service.MemberService;

@Controller
@RequestMapping(value = "/naver")
public class MemberNaverLoginController {

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	private MemberService memberService;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO, MemberService memberService) {
		this.naverLoginBO = naverLoginBO;
		this.memberService = memberService;
	}


	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱
		String email = (String) response_obj.get("email");

		// member 정보가 db에 있을 경우, login 정보 그대로 사용
		LoginCommand member = memberService.login(email);

		System.out.println("네이버 로그인 정보 : " + apiResult);

		if (memberService.idDup(email) == 0) {

			InsertCommand insertCommand = new InsertCommand();

			// 생일
			insertCommand.setMemberBirthDay((String) response_obj.get("birthday"));
			// 이메일
			insertCommand.setMemberId(email);

			// 닉네임 랜덤 설정 -> insert 이후, 회원이 직접 수정 가능

			Random random = new Random();
			StringBuffer buffer = new StringBuffer();
			int num = 0;

			while (buffer.length() < 6) {
				num = random.nextInt(10);
				buffer.append(num);
			}

			String memberNickname = "USER_" + buffer.toString();

			if (memberService.nicknameDup(memberNickname) == 0) {
				insertCommand.setMemberNickname(memberNickname);

			} else if (memberService.nicknameDup(memberNickname) != 0) {

				System.out.println("user임시 닉네임 중복");
				memberNickname = "USER_" + buffer.toString() + "_N";
			}
			
			// 임시 비밀번호 셋팅
			insertCommand.setMemberPassword("naverLogin_tmpPW");

			// db 등록
			System.out.println("db저장 값 \n" + insertCommand);
			memberService.memberInsert(insertCommand);

			// member insert 후, memberId로 login 정보 셋팅
			member = memberService.login(email);

			// api 상태 변경
			memberService.updateApiStatus("naver", member.getMemberSeq());

		}
		// 4.파싱 닉네임 세션으로 저장

		session.setAttribute("memberLogin", member); // 세션 생성

		return "/main/main";
	}

}
