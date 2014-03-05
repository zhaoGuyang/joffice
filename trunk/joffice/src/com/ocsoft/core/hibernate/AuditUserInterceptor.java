package com.ocsoft.core.hibernate;

import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.CallbackException;
import org.hibernate.EmptyInterceptor;
import org.hibernate.EntityMode;
import org.hibernate.Transaction;
import org.hibernate.type.Type;

import com.ocsoft.core.vo.BaseVO;


public class AuditUserInterceptor extends EmptyInterceptor
{
	private static final Log logger = LogFactory.getLog(AuditUserInterceptor.class);
	private static String EDIT_USER = "editUser";
	private static String EDIT_DATE = "editDate";
	private static String ADD_USER = "addUser";
	private static String ADD_DATE = "addDate";
	@Override
	public boolean onLoad(Object entity, Serializable id, Object[] state,
			String[] propertyNames, Type[] types)
	{
		logger.debug("============onLoad==============="+entity.getClass());
		return true;
	}

	@Override
	public boolean onSave(Object entity, Serializable id, Object[] state,
			String[] propertyNames, Type[] types)
	{
		if(entity instanceof BaseVO)
		{
			BaseVO vo = (BaseVO)entity;
			for(int i=0;i<propertyNames.length;i++)
			{
				if(vo.isIgnoreUserAudit())
					break;
				logger.debug("============onSave propertyNames==============="+propertyNames[i]);
				
					if(ADD_DATE.equals(propertyNames[i]))
					{
						state[i]=new Date();
					}
					if(ADD_USER.equals(propertyNames[i]))
					{
						state[i]=vo.getUser();
					}
				
				if(EDIT_DATE.equals(propertyNames[i]))
				{
					state[i]=new Date();
				}
				if(EDIT_USER.equals(propertyNames[i]))
				{
					state[i]=vo.getUser();
				}
			}
		}
		return true;
	}

	@Override
	public boolean onFlushDirty(Object entity, Serializable id,
			Object[] currentState, Object[] previousState,
			String[] propertyNames, Type[] types)
	{
		if(entity instanceof BaseVO)
		{
			BaseVO vo = (BaseVO)entity;
			for(int i=0;i<propertyNames.length;i++)
			{
				if(vo.isIgnoreUserAudit())
					break;
				//logger.info("============onFlushDirty propertyNames==============="+propertyNames[i]);
				if(EDIT_DATE.equals(propertyNames[i]))
				{
					currentState[i]=new Date();
				}
				if(EDIT_USER.equals(propertyNames[i]))
				{
					currentState[i]=vo.getUser();
				}
			}
		}
		return true;
	}

	@Override
	public void onDelete(Object entity, Serializable id, Object[] state,
			String[] propertyNames, Type[] types)
	{
		// TODO Auto-generated method stub
		super.onDelete(entity, id, state, propertyNames, types);
	}

	@Override
	public void postFlush(Iterator entities)
	{
		// TODO Auto-generated method stub
		super.postFlush(entities);
	}

	@Override
	public void preFlush(Iterator entities)
	{
		// TODO Auto-generated method stub
		super.preFlush(entities);
	}

	@Override
	public Boolean isTransient(Object entity)
	{
		// TODO Auto-generated method stub
		return super.isTransient(entity);
	}

	@Override
	public Object instantiate(String entityName, EntityMode entityMode,
			Serializable id)
	{
		logger.debug("============instantiate==============="+entityName);
		// TODO Auto-generated method stub
		return super.instantiate(entityName, entityMode, id);
	}

	@Override
	public int[] findDirty(Object entity, Serializable id,
			Object[] currentState, Object[] previousState,
			String[] propertyNames, Type[] types)
	{
		// TODO Auto-generated method stub
		return super.findDirty(entity, id, currentState, previousState, propertyNames,
				types);
	}

	@Override
	public String getEntityName(Object object)
	{
		// TODO Auto-generated method stub
		return super.getEntityName(object);
	}

	@Override
	public Object getEntity(String entityName, Serializable id)
	{
		// TODO Auto-generated method stub
		return super.getEntity(entityName, id);
	}

	@Override
	public void afterTransactionBegin(Transaction tx)
	{
		// TODO Auto-generated method stub
		super.afterTransactionBegin(tx);
	}

	@Override
	public void afterTransactionCompletion(Transaction tx)
	{
		// TODO Auto-generated method stub
		super.afterTransactionCompletion(tx);
	}

	@Override
	public void beforeTransactionCompletion(Transaction tx)
	{
		// TODO Auto-generated method stub
		super.beforeTransactionCompletion(tx);
	}

	@Override
	public String onPrepareStatement(String sql)
	{
		// TODO Auto-generated method stub
		return super.onPrepareStatement(sql);
	}

	@Override
	public void onCollectionRemove(Object collection, Serializable key)
			throws CallbackException
	{
		// TODO Auto-generated method stub
		super.onCollectionRemove(collection, key);
	}

	@Override
	public void onCollectionRecreate(Object collection, Serializable key)
			throws CallbackException
	{
		// TODO Auto-generated method stub
		super.onCollectionRecreate(collection, key);
	}

	@Override
	public void onCollectionUpdate(Object collection, Serializable key)
			throws CallbackException
	{
		// TODO Auto-generated method stub
		super.onCollectionUpdate(collection, key);
	}
	
	
}
