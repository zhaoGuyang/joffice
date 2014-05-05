package com.ocsoft.core.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.ocsoft.core.dao.IBaseDao;
import com.ocsoft.core.service.IBaseService;
import com.ocsoft.core.vo.BaseVO;
import com.ocsoft.core.web.JQGridBean;
import com.ocsoft.core.web.paging.PagingBean;
import com.ocsoft.oa.utils.StringUtil;
public class BaseServiceImpl<T extends BaseVO, PK extends Serializable> implements IBaseService<T, PK>
{
	protected Log logger = LogFactory.getLog(BaseServiceImpl.class);
	protected IBaseDao<T, Serializable> dao;

	public void setDao(IBaseDao baseDao)
	{
		this.dao = baseDao;
	}


	@Override
	public T save(T v)
	{
		// TODO Auto-generated method stub
		return dao.save(v);
	}
	
	@Override
	public void saveOrUpdate(T v)
	{
		// TODO Auto-generated method stub
		dao.saveOrUpdate(v);
	}

	@Override
	public T merge(T v)
	{
		// TODO Auto-generated method stub
		return dao.merge(v);
	}

	@Override
	public void evict(T v)
	{
		dao.evict(v);
	}

	@Override
	public T get(PK paramPK)
	{
		return dao.get(paramPK);
	}

	@Override
	public List<T> getAll()
	{
		// TODO Auto-generated method stub
		return dao.getAll();
	}

	@Override
	public List<T> getAll(PagingBean paramPagingBean)
	{
		// TODO Auto-generated method stub
		return dao.getAll(paramPagingBean);
	}
	public JQGridBean getPageList(Map<String, String> params)
	{
		Integer page = 0;
		Integer rows = 0;
		List<Criterion> criterions = new ArrayList<Criterion>();
		Order order = null;
		Criterion c = null;
		Set<String> keys = params.keySet();
		for(String key : keys)
		{
			if("rows".equals(key))
			{
				rows = Integer.valueOf(params.get(key));
				continue;
			}
			else if("page".equals(key) )
			{
				page = Integer.valueOf(params.get(key));
				continue;
			}
			else if("sidx".equals(key) )
			{
				String sortColumn = params.get(key);
				String sort = params.get("sord");
				if(!StringUtil.isBlank(sortColumn) && !StringUtil.isBlank(sort))
				{
					
					if("asc".equals(sort))
					{
						order = Order.asc(sortColumn);
					}
					else if("desc".equals(sort))
					{
						order = Order.desc(sortColumn);
					}
				}
				continue;
			}
			else if("sord".equals(key) 
				|| "search".equals(key) 
				|| "nd".equals(key) 
				|| "maxSize".equals(key) 
				|| "filters".equals(key) 
				|| key.endsWith("_operator"))
				continue;
			String value = params.get(key);
			String operator = params.get(key+"_operator");
			if("like".equals(operator))
			{
				c = Restrictions.like(key, value);
			}
			else
			{
				c = Restrictions.eq(key, value);
			}
			criterions.add(c);
			
		}
		
		return dao.getPageList(page, rows, criterions, order);
	}

	@Override
	public void remove(PK paramPK)
	{
		dao.remove(paramPK);
	}

	@Override
	public void remove(T v)
	{
		dao.remove(v);
	}

	@Override
	public void flush()
	{
		dao.flush();
	}

}