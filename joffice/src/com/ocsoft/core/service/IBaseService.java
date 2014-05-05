package com.ocsoft.core.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ocsoft.core.web.JQGridBean;
import com.ocsoft.core.web.paging.PagingBean;

public interface IBaseService<T, PK extends Serializable>
{
	public T save(T paramT);
	
	public void saveOrUpdate(T paramT);

	public T merge(T paramT);

	public void evict(T paramT);

	public T get(PK paramPK);

	public List<T> getAll();

	public List<T> getAll(PagingBean paramPagingBean);

	//public List<T> getAll(QueryFilter paramQueryFilter);

	public void remove(PK paramPK);

	public void remove(T paramT);

	public void flush();
	public JQGridBean getPageList(Map<String, String> params);
}
