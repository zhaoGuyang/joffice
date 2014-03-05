package com.ocsoft.core.web.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ocsoft.oa.utils.Constants;
import com.ocsoft.oa.utils.StringUtil;

public class LoginInterceptor extends HandlerInterceptorAdapter
{
	private static final Log logger = LogFactory.getLog(LoginInterceptor.class);
	private static final String showLogin= "showLogin.oa";
	private static final String login= "login.oa";
	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
	{
		Object usrLogin = request.getSession().getAttribute(Constants.SESS_USER_KEY);
		String sevPath = request.getServletPath();
		logger.info("ServletPath: "+sevPath);
		String rootPath="";
		if(!StringUtil.isBlankOrNull(sevPath) && !sevPath.equals("/"+showLogin) && !sevPath.equals("/"+login))
		{
			int len = sevPath.split("/").length;
			for(int i=2;i<len;i++)
			{
				rootPath+="../";
			}
			if(usrLogin == null)
			{
				//response.sendRedirect(rootPath+showLogin);
				StringBuffer toLoginScript = new StringBuffer();
				toLoginScript.append("<script type=\"text/javascript\">");
				toLoginScript.append("top.window.location=\""+rootPath+showLogin+"\"");
				toLoginScript.append("</script>");
				logger.info(toLoginScript);
				PrintWriter  writer = response.getWriter();
				writer.write(toLoginScript.toString());
				writer.flush();
			}
		}
		return true;
	}

	
	

}
