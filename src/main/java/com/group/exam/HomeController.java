package com.group.exam;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		if(session.getAttribute("adminAuthInfoCommand")!= null) {
			return "redirect:/admin/main";
		}else if(session.getAttribute("memberLogin")!=null) {
			return "redirect:/board/todayArticle";
		}
		return "index";
	}
	
}
