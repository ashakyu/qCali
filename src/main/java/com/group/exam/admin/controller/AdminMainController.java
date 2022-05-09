package com.group.exam.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.group.exam.admin.command.AdminRankCommand;
import com.group.exam.admin.service.AdminService;
import com.group.exam.board.command.BoardlistCommand;
import com.group.exam.board.service.BoardService;
import com.group.exam.utils.Criteria;
import com.group.exam.utils.PagingVo;

@Controller
public class AdminMainController {
	
	private AdminService adminService;
	private BoardService boardService;
	
	@Autowired
	public AdminMainController(AdminService adminService, BoardService boardService) {
		this.adminService = adminService;
		this.boardService = boardService;
	}
	
	@RequestMapping("/admin/main")
	public String main(Model model, Criteria cri) {
		
		List<AdminRankCommand> rank = adminService.memberRank();
		model.addAttribute("rank", rank);
		
		List<AdminRankCommand> rankReply = adminService.memberRankReply();
		model.addAttribute("reply", rankReply);

		List<AdminRankCommand> diary = adminService.memberRankDiary();
		model.addAttribute("diary", diary);
		
		int total = boardService.boardTodayCount();
		List<BoardlistCommand> list = boardService.boardListTodayArticle(cri);
		model.addAttribute("list", list);
		
		PagingVo pageCommand = new PagingVo();
		pageCommand.setCri(cri);
		pageCommand.setTotalCount(total);
		model.addAttribute("boardTotal", total);
		model.addAttribute("pageMaker", pageCommand);

		return "/admin/main";
	}

}
