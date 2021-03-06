package com.group.exam.diary.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.group.exam.diary.command.DiaryLikeCommand;
import com.group.exam.diary.command.DiaryListCommand;
import com.group.exam.diary.command.DiaryUpdateCommand;
import com.group.exam.diary.service.DiaryService;
import com.group.exam.diary.vo.DiaryHeartVo;
import com.group.exam.diary.vo.DiaryVo;
import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.service.MemberService;
import com.group.exam.utils.Criteria;
import com.group.exam.utils.PagingVo;

@Controller
@RequestMapping("/diary")
public class DiaryController {

	private DiaryService diaryService;

	private MemberService memberService;

	@Autowired
	public DiaryController(DiaryService diaryService, MemberService memberService) {
		this.diaryService = diaryService;
		this.memberService = memberService;
	}

	@GetMapping(value = "/write/{memberSeq}")
	public String insertDiary(@PathVariable int memberSeq, @ModelAttribute("diaryData") DiaryVo diaryVo,
			HttpSession session) {
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		// login seq ??? ?????????(??????)seq ??????
		if (memberSeq != loginMember.getMemberSeq()) {
			return "errors/memberAuthErrorDiary";
		}
		return "diary/writeForm";
	}

	@PostMapping(value = "/write/{memberSeq}")
	public String insertDiary(@PathVariable int memberSeq, @Valid @ModelAttribute("diaryData") DiaryVo diaryVo,
			BindingResult bindingResult, Criteria cri, HttpSession session, Model model, HttpServletRequest request)
			throws IllegalStateException, IOException {
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		// login seq ??? ?????????(??????)seq ??????
		if (memberSeq != loginMember.getMemberSeq()) {

			return "errors/memberAuthErrorDiary";
		}

		// not null ??????
		if (bindingResult.hasErrors()) {

			return "diary/writeForm";
		}

		boolean memberAuth = diaryService.memberAuth(loginMember.getMemberSeq()).equals("F");
		if (memberAuth == true) {
			return "errors/memberAuthError"; // ????????? ?????? x -> ?????? ?????????
		}

		// ???????????? ??????
		String diaryOpen = request.getParameter("open");
		diaryVo.setDiaryOpen(diaryOpen);

		// ???????????? ????????? mSeq ??? diaryVo??? ??????
		diaryVo.setMemberSeq(loginMember.getMemberSeq());

		// ???????????? ??????
		MultipartFile file = diaryVo.getImg();
		if (!file.isEmpty()) {
			diaryVo.setDiaryImg(diaryService.upload("diary", file, session));
		} else {
			diaryVo.setDiaryImg(null);
		}

		// ?????????
//		String originalFileName = file.getOriginalFilename();
//		
//		//????????? ??? ???????????? ??????
//		String originalFileExtension = FilenameUtils.getExtension(originalFileName); //????????? ?????????
//		
//		if(originalFileExtension!="") { //????????????????????? (????????? ???????????????
//		System.out.println("originalFileExtension ??????         :"+originalFileExtension);
//		
//		//???????????? ??? ????????? ???????????? + ?????????
//		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "")+"."+originalFileExtension;
//		
//		//?????? ????????? ?????? File ??????
//		String rootPath = request.getSession().getServletContext().getRealPath("/");  
//
//		//????????????
//	    String attachPath = "resources/upload/";
//		file.transferTo(new File(rootPath + attachPath +storedFileName));
//	
//		diaryVo.setDiaryImg(storedFileName); //????????? ?????? (???????????????)????????? vo??? ??????
//			
//		}else if(originalFileExtension=="") { //????????????????????? (?????? ????????????
//			diaryVo.setDiaryImg(null);
//		}
//		

		// insert
		diaryService.insertDiary(diaryVo);

		// update

//		int mytotal = diaryService.mylistCount(loginMember.getMemberSeq());

//		if (mytotal > 10) {
//			int memberLevel = boardService.memberLevelup(loginMember.getMemberSeq(), mytotal,
//					loginMember.getMemberLevel());
//
//			if (memberLevel == 1) {
//
//				LoginCommand member = memberService.login(loginMember.getMemberId());
//
//				LoginCommand login = member;
//
//				session.setAttribute("memberLogin", login);
//
//				model.addAttribute("level", login.getMemberLevel());
//				model.addAttribute("nickname", login.getMemberNickname());
//
//				return "/member/member_alert/levelUp";
//
//			}
//		}

		return "redirect:/diary/list/" + loginMember.getMemberSeq();
	}

	// ??????list ??? ??? ????????????
	@GetMapping(value = "/list/{memberSeq}")
	public String boardListMy(@PathVariable Long memberSeq, Model model, Criteria cri, HttpSession session) {

		int total = diaryService.diaryListCount(memberSeq);

		List<DiaryListCommand> list = diaryService.diaryList(cri, memberSeq);
		model.addAttribute("diaryList", list);

		String diaryNickname = diaryService.diaryNickname(memberSeq);

		model.addAttribute("diaryNickname", diaryNickname);
		PagingVo pageCommand = new PagingVo();
		pageCommand.setCri(cri);
		pageCommand.setTotalCount(total);
		model.addAttribute("diaryTotal", total);
		model.addAttribute("pageMaker", pageCommand);

		model.addAttribute("testMemberSeq", memberSeq);
		return "diary/list";
	}

	// ????????? ?????????
	@GetMapping(value = "/detail")
	public String diaryDetail(@RequestParam Long diarySeq, Model model, HttpSession session) {

		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		if (loginMember == null) {
			return "errors/notLoginError"; // ????????? ????????? ?????? ???
		}

		diaryService.diaryCountup(diarySeq);

		DiaryListCommand list = diaryService.diaryDetail(diarySeq);
		boolean myArticle = false;
		// ?????? ??? loginMember??? ??????

		if (loginMember != null) {
			// ???????????? ????????? mSeq ??? boardVo??? ??????
			Long memberSeq = loginMember.getMemberSeq();
			// ????????? ????????? mSeq??? ???????????? mSeq??? ???????????? ??? ????????? ?????? ?????? ????????? ??????
			if (memberSeq == list.getMemberSeq()) {
				myArticle = true;
			}

			model.addAttribute("myArticle", myArticle);
		}

		model.addAttribute("diaryList", list);
		model.addAttribute("diarySeq", diarySeq);

		DiaryHeartVo likeVo = new DiaryHeartVo();

		likeVo.setDiarySeq(diarySeq);
		likeVo.setMemberSeq(loginMember.getMemberSeq());

		int diarylike = diaryService.getDiaryLike(likeVo);

		model.addAttribute("diaryHeart", diarylike);
		System.out.println(list);
		return "diary/detail";

	}

	@PostMapping(value = "/heart", produces = "application/json")
	@ResponseBody
	public int boardLike(@RequestBody DiaryLikeCommand command, HttpSession session) {

		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		DiaryHeartVo likeVo = new DiaryHeartVo();

		likeVo.setDiarySeq(command.getDiarySeq());
		likeVo.setMemberSeq(loginMember.getMemberSeq());

		if (command.getDiaryHeart() >= 1) {
			diaryService.deleteDiaryLike(likeVo);
			command.setDiaryHeart(0);
		} else {

			diaryService.insertDiaryLike(likeVo);
			command.setDiaryHeart(1);
		}

		return command.getDiaryHeart();

	}

	// ????????? ??????
	@GetMapping(value = "/edit/{diarySeq}")
	public String diaryEdit(@PathVariable Long diarySeq,
			@ModelAttribute("diaryData") DiaryUpdateCommand updateCommand, Model model, HttpSession session) {

//			//login seq ??? ?????????(??????)seq ??????
//			if (diarySeqTest != updateCommand.getDiarySeq()) {
//
//				return "errors/memberAuthErrorDiary";
//			}
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		DiaryListCommand list = diaryService.diaryDetail(diarySeq);
		if (loginMember.getMemberSeq() == list.getMemberSeq()) {
			model.addAttribute("diaryList", list);
			return "diary/editForm";
		} else {
			return "errors/memberAuthErrorDiary";
		}
	}

	// ????????? ??????
	@PostMapping(value = "/edit/{diarySeq}")
	public String diaryEdit(@PathVariable Long diarySeq,
			@Valid @ModelAttribute("diaryData") DiaryUpdateCommand updateCommand, BindingResult bindingResult,
			Model model, HttpSession session, HttpServletRequest request) throws IllegalStateException, IOException {
		if (bindingResult.hasErrors()) {
			// ????????? ?????? ?????? ?????? ????????????
			DiaryListCommand list = diaryService.diaryDetail(diarySeq);
			model.addAttribute("diaryList", list);
			return "diary/editForm";
		}

		// ?????? ??? loginMember??? ??????
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		if (loginMember != null) {

			// ???????????? ??????
			String diaryOpen = request.getParameter("open");
			updateCommand.setDiaryOpen(diaryOpen);

			// ???????????? ??????
			MultipartFile file = updateCommand.getImg();
			if(!file.isEmpty()) {
				updateCommand.setDiaryImg(diaryService.upload("diary", file, session));
			}else{
				updateCommand.setDiaryImg(null);
			}

			diaryService.updateDiary(updateCommand.getDiaryTitle(), updateCommand.getDiaryContent(), diarySeq,
					updateCommand.getDiaryOpen(), updateCommand.getDiaryImg());

			System.out.println(" ?????? ??????");
		} else {
			System.out.println("?????? ??????");
			return "errors/mypageChangeError";
		}

		return "redirect:/diary/list/" + loginMember.getMemberSeq();
	}

	// ????????? ??????
	@GetMapping(value = "/delete")
	public String diaryDelete(@RequestParam Long diarySeq, Model model, HttpSession session, Criteria cri) {

		// ?????? ??? loginMember??? ??????
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		if (loginMember != null) {
			// ???????????? ????????? mSeq ??? boardVo??? ??????
			Long memberSeq = loginMember.getMemberSeq();
			diaryService.deleteDiary(diarySeq, memberSeq);
			System.out.println("?????? ??????");
		} else {
			System.out.println("?????? ??????");
			return "errors/mypageChangeError";
		}

		return "redirect:/diary/list/" + loginMember.getMemberSeq();
	}

	// ????????? ???????????? ??????
	@GetMapping(value = "/deleteImg")
	public String diaryDeleteImg(@RequestParam Long diarySeq, Model model, HttpSession session, Criteria cri) {

		// ?????? ??? loginMember??? ??????
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		if (loginMember != null) {
			diaryService.deleteDiaryImg(diarySeq);
			System.out.println("?????? ??????");
		} else {
			System.out.println("?????? ??????");
			return "errors/mypageChangeError";
		}

		return "redirect:/diary/detail?diarySeq=" + diarySeq;
	}
	// ckeditor ??????
}
