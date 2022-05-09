package com.group.exam.utils;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CommonExceptionHandler {

	@ExceptionHandler(Exception.class)
	public String commonErrors(Exception e) {
		
		System.out.println("common Error:\t" + e.getMessage());
		
		return "errors/commonException";
	}
}
