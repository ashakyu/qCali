package com.group.exam.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.service.MemberService;

@Controller
public class MemberQuestionController {

	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/member/questionAdd", method = RequestMethod.GET)
	public String questionAdd (HttpSession session, Model model) {
		
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		// 로그인 세션 없을 때 ->main
		if (loginMember == null) {
			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}

		return "/member/questionAddForm";
	}
	
	@RequestMapping(value = "/member/questionAdd", method = RequestMethod.POST)
	public String questionAdd (@RequestParam(required = false) String questionContent, HttpSession session, Model model) {
		
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		// 로그인 세션 없을 때 ->main
		if (loginMember == null) {
			model.addAttribute("msg", "로그인이 후에 이용 가능합니다.");
			return "member/member_alert/alertGoMain";
		}

		System.out.println(questionContent.equals(""));
		if (questionContent.equals(null) || questionContent.length() == 0) {
			model.addAttribute("msg", "내용을 입력해 주세요.");
			return "/member/questionAddForm";
		}

		
		int result = memberService.memberQuestionAdd(questionContent, loginMember.getMemberSeq());
		
		if(result != 1) {
			model.addAttribute("msg", "등록 에러.\n 관리자에게 문의해주세요.");
			return "member/member_alert/alertGoMain"; 
		}
		
		model.addAttribute("msg", "관리자 확인 후, 질문이 등록됩니다.");
		return "member/member_alert/alertGoBoardList"; 
	}
	
	
	
}
