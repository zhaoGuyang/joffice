package com.ocsoft.core.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.ocsoft.core.dao.IBaseDao;
import com.ocsoft.core.vo.BaseVO;
import com.ocsoft.core.web.JQGridBean;
import com.ocsoft.core.web.paging.PagingBean;

public class BaseDaoImpl<T extends BaseVO, PK extends Serializable> implements IBaseDao<T, PK>
{
	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;

	public Session getSession()
	{
		Session session = sessionFactory.getCurrentSession();
		// session.setFlushMode(FlushMode.COMMIT);
		return session;
	}

	protected final Class<T> entityClass;
	protected final String HQL_LIST_ALL;
	protected final String HQL_COUNT_ALL;

	// private final String HQL_OPTIMIZE_PRE_LIST_ALL;
	// private final String HQL_OPTIMIZE_NEXT_LIST_ALL;
	// private String pkName = null;

	@SuppressWarnings("unchecked")
	public BaseDaoImpl()
	{
		this.entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
		// TODO @Entity name not null
		HQL_LIST_ALL = "from " + this.entityClass.getName();
		// HQL_OPTIMIZE_PRE_LIST_ALL = "from " +
		// this.entityClass.getSimpleName() ;
		// HQL_OPTIMIZE_NEXT_LIST_ALL = "from " +
		// this.entityClass.getSimpleName() ;
		HQL_COUNT_ALL = " select count(*) from " + this.entityClass.getName();
	}
	
	@Override
	public T save(T paramT)
	{
		getSession().save(paramT);
		return paramT;
	}
	public void saveOrUpdate(T paramT)
	{
		getSession().saveOrUpdate(paramT);
	}

	@Override
	public T merge(T paramT)
	{
		getSession().merge(paramT);
		return paramT;
	}

	@Override
	public T get(PK paramPK)
	{
		return  (T) getSession().get(entityClass, paramPK);
	}

	@Override
	public void remove(PK paramPK)
	{
		T obj = get(paramPK);
		getSession().delete(obj);

	}

	@Override
	public void remove(T paramT)
	{
		getSession().delete(paramT);

	}

	@Override
	public void evict(T paramT)
	{
		getSession().evict(paramT);

	}

	@Override
	public List<T> getAll()
	{
		Query query = getSession().createQuery(HQL_LIST_ALL);
		return query.list();
	}

	@Override
	public List<T> getAll(PagingBean pagingBean)
	{
		int cnt = count(HQL_COUNT_ALL, new HashSet());
		pagingBean.setTotalItems(cnt);
		Query query = getSession().createQuery(HQL_LIST_ALL);
		query.setFirstResult(pagingBean.getFirstResult());
		query.setFetchSize(pagingBean.getPageSize());
		query.setMaxResults(pagingBean.getPageSize());
		return query.list();
	}
	
	public JQGridBean getPageList(Integer page, int rows, List<Criterion> criterions, Order order)
	{
		JQGridBean jqGrid = new JQGridBean();
		Criteria criteria = this.getSession().createCriteria(entityClass);
		for(Criterion criterion : criterions)
		{
			criteria.add(criterion);
		}
		if(order != null)
		{
			criteria.addOrder(order);
		}
		Integer total = criteria.list().size();
		
		int limit = rows;
		int totalPages =  total/limit;
		if (total%limit != 0) {
			totalPages++;
		}
		int currPage = Math.min(totalPages, page);
		
		int start = currPage * limit - limit;
		start = start < 0 ? 0 : start;
		
		criteria.setFirstResult(start);
		criteria.setFetchSize(limit);
		criteria.setMaxResults(limit);
		
		List records = criteria.list();
		
		jqGrid.setPage(currPage);
		jqGrid.setRows(records);
		jqGrid.setTotal(totalPages);
		jqGrid.setRecords(total);
		
		return jqGrid;
	}

	@Override
	public List<T> findByHql(String hql, Object[] params)
	{
		Query query = getSession().createQuery(hql);
		if(params != null && params.length>0)
		{
			for(int i = 0;i<params.length;i++)
			{
				query.setParameter(i, params[i]);
			}
		}
		return query.list();
	}

	@Override
	public List<T> findByHql(String hql, Object[] params, PagingBean pagingBean)
	{
		return findByHql(hql, params, pagingBean.getFirstResult(), pagingBean.getPageSize());
	}

	@Override
	public List<T> findByHql(String hql, Object[] params, int firstResult, int pageSize)
	{
		Query query = getSession().createQuery(hql);
		query.setFirstResult(firstResult);
		query.setMaxResults(pageSize);
		if(params != null && params.length>0)
		{
			for(int i = 0;i<params.length;i++)
			{
				query.setParameter(i, params[i]);
			}
		}
		return query.list();
	}

	@Override
	public void flush()
	{
		getSession().flush();

	}

	@Override
	public Long update(String hql, Object[] params)
	{
		// TODO Auto-generated method stub
		return null;
	}
	
	
	public int count(String hql, Set params)
	{
		Number cnt = (Number)unique(hql,params.toArray());
		return cnt.intValue();
	}
	
	protected Object unique(final String hql, final Object... paramlist)
	{
		Query query = getSession().createQuery(hql);
		if (paramlist != null)
		{
			for (int i = 0; i < paramlist.length; i++)
			{
				query.setParameter(i, paramlist[i]);
			}
		}
		return query.setMaxResults(1).uniqueResult();
	}
	public List<T> getByCriteria(List<Criterion>  criterions)
	{
		Criteria criteria = getSession().createCriteria(entityClass);
		for(Criterion c : criterions)
		{
			criteria.add(c);
		}
		return criteria.list();
	}

}