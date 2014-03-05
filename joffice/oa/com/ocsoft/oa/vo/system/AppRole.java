package com.ocsoft.oa.vo.system;

import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ocsoft.core.vo.BaseVO;

public class AppRole extends BaseVO
{
	private Long roleId;
	private String roleName;
	private String userIds;
	@JsonIgnore
	private Set<AppGroup> groups;
	public Long getRoleId()
	{
		return roleId;
	}
	public void setRoleId(Long roleId)
	{
		this.roleId = roleId;
	}
	public String getRoleName()
	{
		return roleName;
	}
	public void setRoleName(String roleName)
	{
		this.roleName = roleName;
	}
	@JsonIgnore
	public Set<AppGroup> getGroups()
	{
		return groups;
	}
	
	private void setGroups(Set<AppGroup> groups)
	{
		this.groups = groups;
	}
	public void addGroup(AppGroup group)
	{
		this.getGroups().add(group);
	}
	
	public String getUserIds()
	{
		return userIds;
	}
	public void setUserIds(String userIds)
	{
		this.userIds = userIds;
	}
	
	
}
