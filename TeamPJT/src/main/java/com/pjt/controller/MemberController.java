package com.pjt.controller;

import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pjt.member.commend.MemberVO;
import com.pjt.service.MemberService;



@Controller
@RequestMapping("/member")
public class MemberController {

	
	@Autowired
	private MemberService memberservice;
	
	//로그인 화면
	@RequestMapping("/login")
	public String login() {
		return "/pjt/member/login";
	}
	
	@RequestMapping("/join")
	public String join() {
		return "/pjt/member/join";
	}
	
	@RequestMapping(value="/checkId",method=RequestMethod.POST)
	@ResponseBody
	public int checkId(@RequestParam("user_id") String id) {
		System.out.println(id);
		int result = memberservice.idCheck(id);
		
		return result;
	}
	@RequestMapping("/joinForm")
	public String joinForm(MemberVO vo, RedirectAttributes RA) {
		
		int result = memberservice.join(vo);
		System.out.println(result);
		if(result==1){
			RA.addFlashAttribute("msg", "가입성공");
		}else {
			RA.addFlashAttribute("msg", "가입실패");
		}
		
//		return "redirect:/";
		return "redirect:/member/join_ok";
	}
	
	
	@RequestMapping("join_ok")
	public String join_ok() {
		
		return "/pjt/member/join_ok";
	}
	
	@RequestMapping("/loginForm")
	public String loginForm(MemberVO vo, HttpSession session,RedirectAttributes RA) {
		
		System.out.println("실행1");
		int result = memberservice.login(vo);
		System.out.println(vo.getUser_id()+"/"+result);
		System.out.println(result);
		if(result ==1) {
			session.setAttribute("user_id", vo.getUser_id());
			RA.addFlashAttribute("msg", "환영합니다.");
			return "redirect:/pjt/main";
		}else {
			System.out.println("실행3");
			RA.addFlashAttribute("msg", "아이디 비밀번호 확인해주세요");
			return "redirect:/member/login";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
	
	@RequestMapping("/mypage")
	public String mypage() {
		return "/pjt/member/mypage";
	}
	
	@RequestMapping("/update_member")
	public String update_member() {
		return "/pjt/member/update_member";
	}
	
	@RequestMapping("/update_pw")
	public String update_pw() {
		return "/pjt/member/update_pw";
	}
	
	@RequestMapping("/delete")
	public String delete() {
		return "/pjt/member/delete";
	}
	
	
}
