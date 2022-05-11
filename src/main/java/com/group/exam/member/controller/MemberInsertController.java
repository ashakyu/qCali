package com.group.exam.member.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.group.exam.member.command.InsertCommand;
import com.group.exam.member.command.NaverLoginBO;
import com.group.exam.member.service.MailSendService;
import com.group.exam.member.service.MemberService;

@Controller
public class MemberInsertController {

	private BCryptPasswordEncoder passwordEncoder;

	private MemberService memberService;

	private MailSendService mss;
	private MemberKakaoController kakao;
	private NaverLoginBO naverLoginBO;

	@Autowired
	public MemberInsertController(BCryptPasswordEncoder passwordEncoder, MemberService memberService,
			MailSendService mss, MemberKakaoController kakao, NaverLoginBO naverLoginBO) {
		// TODO Auto-generated constructor stub

		this.passwordEncoder = passwordEncoder;
		this.memberService = memberService;
		this.naverLoginBO = naverLoginBO;
		this.mss = mss;
		this.kakao = kakao;

	}

	@RequestMapping(value = "/member/insert", method = RequestMethod.GET)
	public String insert(@ModelAttribute("InsertCommand") InsertCommand insertCommand, HttpSession session, Model model) {
		// 네이버 로그인
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		System.out.println("네이버:" + naverAuthUrl);
		model.addAttribute("naverLoginURL", naverAuthUrl);

		// 카카오 로그인 추가
		String kakaoUrl = kakao.getAuthorizationUrl(session);
		System.out.println("카카오:" + kakaoUrl);
		model.addAttribute("kakao_url", kakaoUrl);

		// 로그인 세션이 이미 있을 경우
		if (session.getAttribute("memberLogin") != null) {
			return "/main";
		}

		return "/member/insertForm";
	}

	@RequestMapping(value = "/member/insert", method = RequestMethod.POST)
	public String insert(@Valid @ModelAttribute("InsertCommand") InsertCommand insertCommand,
			BindingResult bindingResult, Model model) throws Exception, IOException {

		if (bindingResult.hasErrors()) {
			System.out.println(bindingResult.getAllErrors());

			return "/member/insertForm";
		}

		boolean pwdcheck = insertCommand.getMemberPassword().equals(insertCommand.getMemberPasswordCheck());
		if (pwdcheck != true) {

			return "/member/insertForm";
		}

		System.out.println(insertCommand);

		// 비밀번호 암호화
		String encodedPw = passwordEncoder.encode(insertCommand.getMemberPassword());
		// 암호화한 비번 셋
		insertCommand.setMemberPassword(encodedPw);
		// insert
		memberService.memberInsert(insertCommand);

		// 인증 메일을 발송,인증키 6자리 String 반환
		String authKey = mss.sendAuthMail(insertCommand.getMemberId());
		// 인증키 셋
		insertCommand.setMemberAuthkey(authKey);

		// DB에 인증키 업데이트
		memberService.updateAuthkey(insertCommand);

		model.addAttribute("msg", "메일로 인증 메일이 발송 되었습니다.");
		return "/member/member_alert/alertGoMain";
	}

	@ResponseBody
	@RequestMapping(value = "/member/idDup", method = RequestMethod.POST)
	public int idDup(@ModelAttribute("InsertCommand") InsertCommand insertCommand) {
		String memberId = insertCommand.getMemberId();
		System.out.println("???????" + memberId);

		return memberService.idDup(memberId);

	}

	@ResponseBody
	@RequestMapping(value = "/member/nicknameDup", method = RequestMethod.POST)
	public int nicknameDup(@ModelAttribute("InsertCommand") InsertCommand insertCommand) {
		String memberNickname = insertCommand.getMemberNickname();
		int res = 1;
		if (memberNickname.length() >= 1) {
			res = memberService.nicknameDup(memberNickname);
		}
		return res;

	}

}
