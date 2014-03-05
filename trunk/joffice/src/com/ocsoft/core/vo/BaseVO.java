package com.ocsoft.core.vo;

import java.io.Serializable;
import java.util.Date;

public class BaseVO implements Serializable
{
	private Date addDate;
	private String addUser;

	private Date editDate;
	private String editUser;
	private String user;
	
	private boolean ignoreUserAudit = false;

	public String getUser()
	{
		return user;
	}

	public void setUser(String user)
	{
		this.user = user;
	}

	public Date getAddDate()
	{
		return addDate;
	}

	public void setAddDate(Date addDate)
	{
		this.addDate = addDate;
	}

	public String getAddUser()
	{
		return addUser;
	}

	public void setAddUser(String addUser)
	{
		this.addUser = addUser;
	}

	public Date getEditDate()
	{
		return editDate;
	}

	public void setEditDate(Date editDate)
	{
		this.editDate = editDate;
	}

	public String getEditUser()
	{
		return editUser;
	}

	public void setEditUser(String editUser)
	{
		this.editUser = editUser;
	}

	public boolean hasUserField()
	{
		return true;
	}

	public boolean isIgnoreUserAudit()
	{
		return ignoreUserAudit;
	}

	public void setIgnoreUserAudit(boolean ignoreUserAudit)
	{
		this.ignoreUserAudit = ignoreUserAudit;
	}
}
