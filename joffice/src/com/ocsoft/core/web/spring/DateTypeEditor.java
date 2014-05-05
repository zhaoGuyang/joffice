package com.ocsoft.core.web.spring;

import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTypeEditor extends PropertyEditorSupport
{
	public static final DateFormat DF_LONG = new SimpleDateFormat( "MM/dd/yyyy HH:mm:ss");
	public static final DateFormat DF_SHORT = new SimpleDateFormat("MM/dd/yyyy");
	public static final DateFormat DF_YEAR = new SimpleDateFormat("yyyy");
	public static final DateFormat DF_MONTH = new SimpleDateFormat("MM/yyyy");
	@Override
	public String getAsText()
	{
		Date value = (Date) getValue();
		return (value != null ? DF_SHORT.format(value) : "");
	}
	@Override
	public void setAsText(String text) throws IllegalArgumentException
	{
		try
		{
			if(text !=null && text.trim().length()>0)
			super.setValue(DF_SHORT.parse(text));
		}
		catch (ParseException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}