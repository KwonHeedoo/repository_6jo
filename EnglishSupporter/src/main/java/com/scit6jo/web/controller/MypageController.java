package com.scit6jo.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.scit6jo.web.repository.MypageRepository;


@Controller
public class MypageController {
	@Autowired
	MypageRepository repository;
	
	
}
