package com.ocsoft.oa.dao.system.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.ocsoft.core.dao.impl.BaseDaoImpl;
import com.ocsoft.oa.dao.system.IModuleDAO;
import com.ocsoft.oa.vo.system.Module;
@Repository("moduleDAO")
public class ModuleDAOImpl extends BaseDaoImpl<Module, Long> implements IModuleDAO
{

	@Override
	public List<Module> getByPId(Long pId)
	{
		Query query = getSession().createQuery(HQL_LIST_ALL+" m where m.parentId=:pId");
		query.setLong("pId", pId);
		return query.list();
	}
	
	@Override
	public List<Module> getByClientId(Long clientId)
	{
		return getSession().createCriteria(entityClass)
					.add(Restrictions.eq("clientId", clientId))
					.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Module> getByCidAndPid(Long clientId, Long parentId)
	{
		return getSession().createCriteria(entityClass)
		.add(Restrictions.eq("clientId", clientId))
		.add(Restrictions.eq("parentId", parentId))
		.list();
	}

	@Override
	public Module getByResSn(String resSn)
	{
		return (Module)getSession().createCriteria(entityClass)
				.add(Restrictions.eq("resSn", resSn))
				.uniqueResult();
	}
	
	

}
