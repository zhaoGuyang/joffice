package com.ocsoft.core.util;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class ApplicationContextHolder implements ApplicationContextAware
{
	private static Log logger = LogFactory.getLog(ApplicationContextHolder.class);
	private static Map<String, ApplicationContext> applicationContextCache = new HashMap<String, ApplicationContext>();
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException
	{
		
		logger.info("===Context name : "+applicationContext.getDisplayName());
		applicationContextCache.put(applicationContext.getDisplayName(), applicationContext);

	}
	
	public static ApplicationContext getApplicationContext(AppCtx contextKey)
	{
		if (applicationContextCache.get(contextKey.getContextName()) == null)
			return applicationContextCache.values().iterator().next();
		
		return applicationContextCache.get(contextKey.getContextName());
	}
	
	
	public enum AppCtx
	{
		ROOT_CONTEXT         ("Root WebApplicationContext"),
		OA_CONTEXT          ("WebApplicationContext for namespace 'SpringOA-servlet'");
		private String contextName;
		AppCtx(String name)
		{
			this.contextName = name;
		}
		
		public String getContextName()
		{
			return this.contextName;
		}
	}

}
