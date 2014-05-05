package com.ocsoft.core.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ContextInterceptor extends HandlerInterceptorAdapter
{
	private static final String BASE_CONTEXT="base_context";
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception
	{
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
		if(modelAndView!=null)
			modelAndView.addObject(BASE_CONTEXT, request.getContextPath());
		
	}

}
