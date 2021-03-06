package com.group.exam.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.group.exam.admin.command.AdminAuthInfoCommand;
import com.group.exam.board.command.BoardlistCommand;
import com.group.exam.board.command.BoardupdateCommand;
import com.group.exam.board.command.QuestionAdayCommand;
import com.group.exam.board.service.BoardService;
import com.group.exam.board.vo.BoardVo;
import com.group.exam.board.vo.NoticeAdminVo;
import com.group.exam.calendar.service.CalendarService;
import com.group.exam.calendar.vo.CalendarVo;
import com.group.exam.member.command.LoginCommand;
import com.group.exam.member.service.MemberService;
import com.group.exam.utils.Criteria;
import com.group.exam.utils.PagingVo;

@Controller
@RequestMapping("/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	public static int num;

	private BoardService boardService;
	private MemberService memberService;
	private CalendarService calendarService;

	@Autowired
	public BoardController(BoardService boardService, MemberService memberService, CalendarService calendarService) {
		this.calendarService = calendarService;
		this.boardService = boardService;
		this.memberService = memberService;

	}

	@GetMapping(value = "/write")
	public String insertBoard(@RequestParam Long questionSeq, @ModelAttribute("boardData") BoardVo boardVo,
			HttpSession session, Model model) {

		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		// ????????? X
		if (loginMember == null) {

			model.addAttribute("msg", "???????????? ?????? ?????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}

		// ????????? ?????? x
		if (boardService.memberAuth(loginMember.getMemberSeq()).equals("F")) {
			model.addAttribute("msg", "????????? ????????? ??????????????????.");
			return "member/member_alert/alertGoBoardList";

		}

		if (num == 0) {
			num = boardService.currentSequence();
			if (num == 0) {
				num = 1;
			}
		}
		logger.info("" + num);
		QuestionAdayCommand question = boardService.questionselect(num);

		model.addAttribute("boardQuestion", question);

		return "board/writeForm";
	}

	@PostMapping(value = "/write")
	public String insertBoard(@Valid @ModelAttribute("boardData") BoardVo boardVo, BindingResult bindingResult,
			Criteria cri, HttpSession session, Model model) {
		// not null ??????
		if (bindingResult.hasErrors()) {

			return "board/writeForm";
		}

		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		// ???????????? ????????? mSeq ??? boardVo??? ??????
		boardVo.setMemberSeq(loginMember.getMemberSeq());

		// insert
		boardService.insertBoard(boardVo);

		// calendar insert
		// boardSeq??? ?????????.
		Long currentSeq = boardService.currentBoardSeq();
		calendarService.insertCalendar(currentSeq);

		int mytotal = boardService.mylistCount(loginMember.getMemberSeq());

		if (mytotal > 10) {
			int memberLevel = boardService.memberLevelup(loginMember.getMemberSeq(), mytotal,
					loginMember.getMemberLevel());

			if (memberLevel == 1) {
				LoginCommand member = memberService.login(loginMember.getMemberId());
				LoginCommand login = member;
				session.setAttribute("memberLogin", login);
				model.addAttribute("msg", member.getMemberNickname() + "??? ????????? " + member.getMemberLevel() + "?????????????????????.");
				return "member/member_alert/alertGoBoardList";

			}
		}

		return "redirect:/board/todayArticle";
	}

	@PostMapping(value = "/ckUpload")
	public void ckUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {

		OutputStream out = null;
		PrintWriter printWriter = null;

		// ?????????
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		// ????????? ???????????? ????????? ??????
		String resources = "C:/qCali/resources/upload";
		String folder = resources + "/" + "board" + "/" + new SimpleDateFormat("yyyy/MM/dd").format(new Date());

		// ?????? ??????
		UUID uuid = UUID.randomUUID();
		String ckUploadPath = uuid + "_" + upload.getOriginalFilename();

		// ?????? ??????
		File f = new File(folder);

		if (!f.exists()) {
			f.mkdirs();
		}

		try {

			byte[] bytes = upload.getBytes();

			out = new FileOutputStream(new File(folder, ckUploadPath));
			out.write(bytes);
			out.flush(); // out??? ????????? ???????????? ???????????? ?????????

			// String callback = request.getParameter("CKEditorFuncNum");
			printWriter = response.getWriter();
			// String fileUrl = "localhost:8080/exam/board/ckUploadSubmit?uuid=" + uuid +
			// "&fileName=" + upload.getOriginalFilename(); // ????????????
			String fileUrl = "/boardImg/" + new SimpleDateFormat("yyyy/MM/dd").format(new Date()) + "/" + ckUploadPath;

			// ???????????? ????????? ??????
			printWriter.println(
					"{\"filename\" : \"" + ckUploadPath + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
			printWriter.flush();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (printWriter != null) {
					printWriter.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	// ????????? ??????
	@GetMapping(value = "/list")
	public String boardListAll(Criteria cri, Model model, HttpSession session) {

		/*
		 * @RequestParam null ?????? ?????? - (required = false) == true ??? ?????? ????????? - @Nullable
		 * ??????????????? ??????
		 * 
		 * - int ?????? ?????? (defaultValue="0")
		 * 
		 */
		
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		AdminAuthInfoCommand adminAuthInfoCommand = (AdminAuthInfoCommand) session.getAttribute("adminAuthInfoCommand");
	
		// ????????? ?????? ?????? ??? ->main
		if (loginMember == null && adminAuthInfoCommand == null) {
			model.addAttribute("msg", "???????????? ?????? ?????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}


		int total = boardService.listCount();

		if (total == 0) {
			total = 1;
		}
		/*
		 * 1 1,10 2 11, 20
		 */

		List<BoardlistCommand> list = boardService.boardList(cri);

		model.addAttribute("boardList", list);

		PagingVo pageCommand = new PagingVo();
		pageCommand.setCri(cri);
		pageCommand.setTotalCount(total);
		model.addAttribute("pageMaker", pageCommand);
		model.addAttribute("boardTotal", total);

		// ??????????????? url
		model.addAttribute("lastUrl", "list");

		if (num == 0) {
			num = boardService.currentSequence();
			if (num == 0) {
				num = 1;
			}
		}
		logger.info("" + num);
		QuestionAdayCommand question = boardService.questionselect(num);

		model.addAttribute("boardQuestion", question);
		System.out.println(question);

		// ?????????
		List<CalendarVo> listCal = null;
		listCal = calendarService.calendarList();

		model.addAttribute("listCal", listCal);

		return "board/list";
	}

	@Scheduled(cron = "0 0 12 1/1 * ?") // ???????????? ???????????? ?????????
	public void getSequence() {
		logger.info(new Date() + "???????????? ??????");
		num = boardService.getSequence();
	}

	// ????????? ??????
	@GetMapping(value = "/edit")
	public String boardEdit(@ModelAttribute("boardEditData") BoardVo boardVo, HttpSession session, Model model) {

		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		// ????????? X
		if (loginMember == null) {

			model.addAttribute("msg", "???????????? ?????? ?????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}
		
		BoardlistCommand articleInfo =  boardService.boardListDetail(boardVo.getBoardSeq());

		model.addAttribute("articleInfo", articleInfo);
		System.out.println("ddddddddd " + loginMember);
		System.out.println("dd" + articleInfo.toString());
		if (loginMember.getMemberSeq().equals( articleInfo.getMemberSeq()) == false) {
			model.addAttribute("msg", "????????? ??????");
			return "member/member_alert/alertGoBoardList";
		}
		return "board/editForm";
	}

	// ????????? ??????
	@PostMapping(value = "/edit")
	public String boardEdit(@Valid @ModelAttribute("boardEditData") BoardupdateCommand updateCommand,
			BindingResult bindingResult, Model model, HttpSession session) {

		if (bindingResult.hasErrors()) {

			return "board/editForm";
		}

		// ?????? ??? loginMember??? ??????
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		if (loginMember != null) {
			// ???????????? ????????? mSeq ??? boardVo??? ??????

			Long boardSeq = updateCommand.getBoardSeq();

			BoardlistCommand list = boardService.boardListDetail(boardSeq);

			model.addAttribute("boardList", list);
			boardService.updateBoard(updateCommand.getBoardTitle(), updateCommand.getBoardContent(), boardSeq);
			System.out.println(" ?????? ??????");
		} else {

			model.addAttribute("msg", "?????? ?????? \n ???????????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}

		return "redirect:/board/todayArticle";
	}

	// ????????? ??????
	@GetMapping(value = "/delete")
	public String boardDelect(@RequestParam Long boardSeq, Model model, HttpSession session, Criteria cri) {

		// ?????? ??? loginMember??? ??????
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");

		if (loginMember != null) {
			// ???????????? ????????? mSeq ??? boardVo??? ??????
			Long memberSeq = loginMember.getMemberSeq();
			boardService.deleteBoardOne(boardSeq, memberSeq);
			System.out.println("?????? ??????");
		} else {
			model.addAttribute("msg", "?????? ?????? \n ???????????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}

		return "redirect:/board/todayArticle";
	}

	// ???????????? or ??? ??? ????????????
	@GetMapping(value = "/memberArticle")
	public String boardListMemberArticle(@RequestParam("memberSeq") Long memberSeq, Model model, Criteria cri,
			HttpSession session) {
		
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		AdminAuthInfoCommand adminAuthInfoCommand = (AdminAuthInfoCommand) session.getAttribute("adminAuthInfoCommand");
	
		// ????????? ?????? ?????? ??? ->main
		if (loginMember == null && adminAuthInfoCommand == null) {
			model.addAttribute("msg", "???????????? ?????? ?????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}

		int total = boardService.mylistCount(memberSeq);

		List<BoardlistCommand> list = boardService.boardMyList(cri, memberSeq);
		model.addAttribute("boardList", list);

		PagingVo pageCommand = new PagingVo();
		pageCommand.setCri(cri);
		pageCommand.setTotalCount(total);
		model.addAttribute("boardTotal", total);
		model.addAttribute("pageMaker", pageCommand);

		model.addAttribute("searchMember", memberSeq);
		return "/board/memberArticleList";
	}

	// ?????? ????????? ??? ??????
	@GetMapping(value = "/todayArticle")
	public String boardListTodayArticle(Model model, Criteria cri, HttpSession session) {

		
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		AdminAuthInfoCommand adminAuthInfoCommand = (AdminAuthInfoCommand) session.getAttribute("adminAuthInfoCommand");
	
		// ????????? ?????? ?????? ??? ->main
		if (loginMember == null && adminAuthInfoCommand == null) {
			model.addAttribute("msg", "???????????? ?????? ?????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}
		
		int total = boardService.boardTodayCount();

		List<BoardlistCommand> list = boardService.boardListTodayArticle(cri);
		model.addAttribute("boardList", list);

	

		PagingVo pageCommand = new PagingVo();
		pageCommand.setCri(cri);
		pageCommand.setTotalCount(total);
		model.addAttribute("boardTotal", total);
		model.addAttribute("pageMaker", pageCommand);

		// ??????????????? url
		model.addAttribute("lastUrl", "todayArticle");

		// ?????? ?????? ??????
		if (num == 0) {
			num = boardService.currentSequence();
			if (num == 0) {
				num = 1;
			}
		}
		logger.info("" + num);
		QuestionAdayCommand question = boardService.questionselect(num);

		model.addAttribute("boardQuestion", question);
		System.out.println(question);

		// ?????????
		List<CalendarVo> listCal = null;
		listCal = calendarService.calendarList();

		model.addAttribute("listCal", listCal);
		
		// ????????????
		List<NoticeAdminVo> notice = boardService.noticelist();
		
		model.addAttribute("notice", notice);

		return "board/list";
	}

	// ????????? , ???????????? ??????
	@GetMapping(value = "/search")
	public String boardSearchList(@RequestParam("searchOption") String searchOption,
			@RequestParam("searchWord") String searchWord, Model model, Criteria cri,  HttpSession session) {
		
		LoginCommand loginMember = (LoginCommand) session.getAttribute("memberLogin");
		AdminAuthInfoCommand adminAuthInfoCommand = (AdminAuthInfoCommand) session.getAttribute("adminAuthInfoCommand");
	
		// ????????? ?????? ?????? ??? ->main
		if (loginMember == null && adminAuthInfoCommand == null) {
			model.addAttribute("msg", "???????????? ?????? ?????? ???????????????.");
			return "member/member_alert/alertGoMain";
		}

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("searchOption", searchOption);
		map.put("searchWord", searchWord);

		int total = boardService.boardSearchCount(map);

		map.put("rowStart", cri.getRowStart());
		map.put("rowEnd", cri.getRowEnd());
		List<BoardlistCommand> list = boardService.boardSearch(map);

		PagingVo pageCommand = new PagingVo();
		pageCommand.setCri(cri);
		pageCommand.setTotalCount(total);
		model.addAttribute("boardTotal", total);
		model.addAttribute("pageMaker", pageCommand);
		model.addAttribute("boardList", list);

		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchWord", searchWord);

		// ?????? ??????

		QuestionAdayCommand question = boardService.questionselect(num);
		model.addAttribute("boardQuestion", question);
		


		return "/board/searchArticleList";
	}

}
