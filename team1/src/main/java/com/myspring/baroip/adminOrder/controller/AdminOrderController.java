// 2021.12.09 ������

package com.myspring.baroip.adminOrder.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface AdminOrderController {

	// ������ ������ �ֹ� ���� ��ü ����
	public ModelAndView adminOrder(HttpServletRequest request, HttpServletResponse response) throws Exception;

	//  ������ ������ �ֹ� ���� ����Ʈ
	public ModelAndView orderList(@RequestParam Map<String, String> info, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}