package com.group.exam.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.group.exam.board.command.BoardlistCommand;
import com.group.exam.board.service.BoardService;
import com.group.exam.member.command.InsertCommand;
import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.command.MemberchangePwd;
import com.group.exam.member.service.MailSendService;
import com.group.exam.member.service.MemberService;
import com.group.exam.utils.Criteria;
import com.group.exam.utils.PagingVo;

@Controller
@RequestMapping(value = "/member")
public class MemberMypageController {

	private MemberService memberService;

	private BoardService boardService;

	private BCryptPasswordEncoder passwordEncoder;

	private MailSendService mss;

	@Autowired
	public MemberMypageController(MemberService memberService, BCryptPasswordEncoder passwordEncoder,
			MailSendService mss, BoardService boardService) {

		this.memberService = memberService;
		this.passwordEncoder = passwordEncoder;
		this.boardService = boardService;
		this.mss = mss;
	}

	@GetMapping(value = "/mypage/confirmPwd")
	public String confirmPwd(String memberPassword, HttpSession session, Model model, Criteria cri) {

		boolean confirmPW = false;

		// api 로그인 시, 비밀번호 확인 안하고 마이페이지 바로 이동.
		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");
		
		// 로그인 X
		if (command == null) {

			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}

		if (command.getNaver().equals("T") || command.getKakao().equals("T")) {

			confirmPW = true;
			model.addAttribute("confirmPW", confirmPW);

			// 마이페이지에 본인 쓴 글 바로 출력
			int total = boardService.mylistCount(command.getMemberSeq());

			List<BoardlistCommand> list = boardService.boardMyList(cri, command.getMemberSeq());
			model.addAttribute("boardList", list);

			PagingVo pageCommand = new PagingVo();
			pageCommand.setCri(cri);
			pageCommand.setTotalCount(total);
			model.addAttribute("boardTotal", total);
			model.addAttribute("pageMaker", pageCommand);

			return "member/mypage";
		}

		model.addAttribute("confirmPW", confirmPW);
		return "/member/mypage";
	}
	
	@GetMapping(value = "/mypage")
	public String confirmPwd(@RequestParam int page, @RequestParam int perPageNum,@RequestParam Long memberSeq,  HttpSession session, Model model, Criteria cri) {

		boolean confirmPW = true;
		
		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");
		
		// 로그인 X
		if (command == null) {

			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}
		
		
		// 마이페이지에 본인 쓴 글 바로 출력
		int total = boardService.mylistCount(command.getMemberSeq());

		List<BoardlistCommand> list = boardService.boardMyList(cri, command.getMemberSeq());
		model.addAttribute("boardList", list);

		PagingVo pageCommand = new PagingVo();
		pageCommand.setCri(cri);
		pageCommand.setTotalCount(total);
		model.addAttribute("boardTotal", total);
		model.addAttribute("pageMaker", pageCommand);

		model.addAttribute("confirmPW", confirmPW);
		return "/member/mypage";
	}

	// 마이페이지 가기 전에 비밀번호 체크
	@PostMapping(value = "/mypage")
	public String confirmPwd(@RequestParam String memberPassword, Model model, HttpSession session, Criteria cri) {

		boolean confirmPW = false;

		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");
		
		
		// 로그인 X
		if (command == null) {

			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}
		

		String encodePassword = memberService.findPwd(command.getMemberId()).getMemberPassword();
		boolean pwdEncode = passwordEncoder.matches(memberPassword, encodePassword);

		if (pwdEncode) {
			confirmPW = true;
			model.addAttribute("confirmPW", confirmPW);

			// 마이페이지에 본인 쓴 글 바로 출력
			int total = boardService.mylistCount(command.getMemberSeq());

			List<BoardlistCommand> list = boardService.boardMyList(cri, command.getMemberSeq());
			model.addAttribute("boardList", list);

			PagingVo pageCommand = new PagingVo();
			pageCommand.setCri(cri);
			pageCommand.setTotalCount(total);
			model.addAttribute("boardTotal", total);
			model.addAttribute("pageMaker", pageCommand);

			return "/member/mypage";
		}

		model.addAttribute("confirmPW", confirmPW);
		model.addAttribute("msg", "비밀번호가 다릅니다.");

		return "/member/mypage";
	}

	// 비밀번호 변경
	@GetMapping(value = "/mypage/changePwd")
	public String changePwd(HttpSession session, Model model) {
		
		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");
		// 로그인 X
		if (command == null) {

			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}
		
		return "/member/changePwdForm";
	}

	@ResponseBody
	@RequestMapping(value = "/mypage/changePwd", produces = "application/json", method = RequestMethod.POST)
	public boolean changePwd(@RequestBody MemberchangePwd changepwdData, HttpSession session) {

		boolean result = false;

		// 비밀번호-비밀번호 확인 check
		boolean pwdcheck = changepwdData.getMemberPassword().equals(changepwdData.getMemberPasswordCheck());

		if (pwdcheck != true) {

			return result;
		}

		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");

		// 임시 비밀번호와 같은지 체크
		String encodePassword = memberService.findPwd(command.getMemberId()).getMemberPassword();
		boolean pwdEncode = passwordEncoder.matches(changepwdData.getMemberPassword(), encodePassword);

		if (pwdEncode) {

			return result;
		}

		// 기존 비밀번호와 같은지 체크

		encodePassword = memberService.findPwd(command.getMemberId()).getMemberBpw();

		pwdEncode = passwordEncoder.matches(changepwdData.getMemberPassword(), encodePassword);

		if (pwdEncode) {

			return result;
		}

		String updateEncodePassword = passwordEncoder.encode(changepwdData.getMemberPassword());

		memberService.updateMemberPwd(updateEncodePassword, command.getMemberSeq());

		// 세션 로그인 정보
		LoginCommand login = memberService.login(command.getMemberId());

		session.setAttribute("memberLogin", login);
		result = true;

		return result;
	}

	// 닉네임 변경
	@GetMapping(value = "/mypage/changeNickname")
	public String changeNickname(HttpSession session, Model model) {
		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");
		// 로그인 X
		if (command == null) {

			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}

		return "/member/changeNicknameForm";
	}

	@PostMapping(value = "/mypage/changeNickname")
	@ResponseBody
	public void changeNickname(@RequestBody String memberNickname, HttpSession session, Model model) {

		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");

		memberService.updateMemberNickname(memberNickname, command.getMemberSeq());

		// 세션 로그인 정보
		LoginCommand login = memberService.login(command.getMemberId());

		session.setAttribute("memberLogin", login);

	}

	// 이메일 인증 번호 재발급
	@GetMapping(value = "/mypage/mailReissue")
	public String mailReissue(HttpSession session, Model model) {
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		// 로그인 세션 없을 때 ->main
		if (loginMember == null) {
			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}

		// 해당 아이디로 이메일 발송
		// 인증 메일을 발송,인증키 6자리 String 반환
		InsertCommand insertCommand = new InsertCommand();
		
		insertCommand.setMemberId(loginMember.getMemberId());
		
		String authKey = mss.sendAuthMail(loginMember.getMemberId());
		
		// 인증키 셋
		insertCommand.setMemberAuthkey(authKey);

		// DB에 인증키 업데이트
		memberService.updateAuthkey(insertCommand);

		model.addAttribute("msg", "이메일로 인증 번호가 재 발송 되었습니다.");
		return "/member/member_alert/alertGoMain";

	}
	

	// 회원 탈퇴
	@GetMapping(value = "/mypage/delete")
	public String deleteMember(@RequestParam String memberSeq) {

		return "/member/deleteForm";

	}

	@PostMapping(value = "/mypage/delete")
	public String deleteMember(@RequestParam String memberPassword, Model model, HttpSession session) {

		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");

		String encodePassword = memberService.findPwd(command.getMemberId()).getMemberPassword();
		boolean pwdEncode = passwordEncoder.matches(memberPassword, encodePassword);

		if (pwdEncode) {

			memberService.deleteMember(command.getMemberSeq());

			session.invalidate(); // 탈퇴 성공시, 로그인 세션 제거
			model.addAttribute("msg", "회원 탈퇴가 완료되었습니다.");
			return "/member/member_alert/alertGoMain";

		}
		model.addAttribute("msg", "비밀번호가 다릅니다.");

		return "/member/deleteForm";
	}

}
