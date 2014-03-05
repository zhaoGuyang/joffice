package com.ocsoft.oa.vo.form;

import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ocsoft.core.vo.BaseVO;

public class CustomForm extends BaseVO
{
	private Long formId;
	private String formName;
	private String formTemplate;
	//private CustomTable customTable;
	@JsonIgnore
	private Set<CustomField> fields = new HashSet<CustomField>();
	public Long getFormId()
	{
		return formId;
	}
	
	public void setFormId(Long formId)
	{
		this.formId = formId;
	}
	public String getFormName()
	{
		return formName;
	}
	public void setFormName(String formName)
	{
		this.formName = formName;
	}
	public String getFormTemplate()
	{
		return formTemplate;
	}
	public void setFormTemplate(String formTemplate)
	{
		this.formTemplate = formTemplate;
	}
	/*public CustomTable getCustomTable()
	{
		return customTable;
	}
	public void setCustomTable(CustomTable customTable)
	{
		this.customTable = customTable;
	}*/

	public Set<CustomField> getFields()
	{
		return fields;
	}

	public void setFields(Set<CustomField> fields)
	{
		this.fields = fields;
	}

	
	
	
}
