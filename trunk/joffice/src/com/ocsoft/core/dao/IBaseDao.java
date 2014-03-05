package com.ocsoft.core.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;

import com.ocsoft.core.vo.BaseVO;
import com.ocsoft.core.web.JQGridBean;
import com.ocsoft.core.web.paging.PagingBean;

public interface IBaseDao<T extends BaseVO, PK extends Serializable>
{
	public T save(T paramT);
	
	public void saveOrUpdate(T paramT);

	public T merge(T paramT);

	public T get(PK paramPK);

	public void remove(PK paramPK);

	public void remove(T paramT);

	public void evict(T paramT);

	public List<T> getAll();

	public List<T> getAll(PagingBean paramPagingBean);

	//public List<T> getAll(QueryFilter paramQueryFilter);

	public List<T> findByHql(String paramString, Object[] paramArrayOfObject);

	public List<T> findByHql(String paramString, Object[] paramArrayOfObject, PagingBean paramPagingBean);

	public List<T> findByHql(String paramString, Object[] paramArrayOfObject, int paramInt1, int paramInt2);

	public void flush();

	public Long update(String paramString, Object[] paramArrayOfObject);
	
	public List<T> getByCriteria(List<Criterion>  criterions);
	
	public JQGridBean getPageList(Integer page, int rows, List<Criterion> criterions, Order order);
}
