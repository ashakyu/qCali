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
	public String questionAdd(HttpSession session) {

		// 로그인 세션
		if (session.getAttribute("memberLogin") == null) {
			return "/main";
		}

		return "/member/questionAddForm";
	}

	@RequestMapping(value = "/member/questionAdd", method = RequestMethod.POST)
	public String questionAdd(@RequestParam(required = false) String questionContent, HttpSession session,
			Model model) {

		if (questionContent.equals(null) || questionContent.length() <= 10) {
			model.addAttribute("msg", "10자 이상 입력해 주세요.");
			return "/member/questionAddForm";
		}

		LoginCommand command = (LoginCommand) session.getAttribute("memberLogin");

		memberService.memberQuestionAdd(questionContent, command.getMemberSeq());

		model.addAttribute("msg", "관리자 승인 후 등록 완료 됩니다.");
		return "/member/member_alert/alertGoMain";
	}

}
