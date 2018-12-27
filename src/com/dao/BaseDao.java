package com.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
//数据访问层接口
//注入所有的数据库操作
@Repository
public class BaseDao<T, PK> extends HibernateDaoSupport {

	@Autowired
	private SessionFactory sessionFactory;

	public void save(T t) {
		getHibernateTemplate().save(t);
	}
	
	public Serializable saveR(T t){
		return  sessionFactory.getCurrentSession().save(t);
	}

	public void delete(T t) {
		getHibernateTemplate().delete(t);
	}

	public void delById(Class<T> t,Integer pk) {
		sessionFactory.getCurrentSession().delete(this.findById(t, pk));
	}

	public void update(Object t) {
		getHibernateTemplate().update(t);		
	}

	public T findById(Class<T> t, Integer pk) {
		return getHibernateTemplate().get(t, pk);
	}

	@SuppressWarnings({ "rawtypes" })
	public List findByExample(T t) {
		try {
			List<Object> results = getHibernateTemplate().findByExample(t);
			return results;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	@SuppressWarnings({ "rawtypes" })
	public List findByProperty(T t, String propertyName, T value) {
		try {
			String queryString = "from" + t + " as model where model." + propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			throw re;
		}
	}

	@SuppressWarnings({ "rawtypes" })
	public List findAll(String t) {
		try {
			String queryString = "from " + t;
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public T merge(T detachedInstance) {
		try {
			T result = getHibernateTemplate().merge(detachedInstance);
			return result;
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void attachDirty(T instance) {
		try {
			getHibernateTemplate().saveOrUpdate(instance);
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public void attachClean(T instance) {
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
		} catch (RuntimeException re) {
			throw re;
		}
	}

	@SuppressWarnings("unchecked")
	public T uniqueQuery(String hql, Object... parameters) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		if (parameters != null && parameters.length > 0) {
			for (int i = 0; i < parameters.length; i++) {
				query.setParameter(i, parameters[i]);
			}
		}
		T t = null;
		try {
			t = (T) query.uniqueResult();
			return t;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@SuppressWarnings({ "unchecked" })
	public List<T> getResult(String hql, Object... parameters) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		if (parameters != null && parameters.length > 0) {

			for (int i = 0; i < parameters.length; i++) {
				query.setParameter(i, parameters[i]);
			}
		}
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<T> pageQuery(String hql, Integer firstResult, Integer maxResults, Object... params) {

		try {
			Query queryObject = sessionFactory.getCurrentSession().createQuery(hql);
			if (null != params)
				for (int i = 0; i < params.length; i++) {
					queryObject.setParameter(i, params[i]);
				}
			if (null != firstResult && null != maxResults) {
				queryObject.setFirstResult(firstResult);
				queryObject.setMaxResults(maxResults);
			}
			return queryObject.list();
		} catch (RuntimeException re) {
			throw re;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<T> pageQuerys(String hql, Integer firstResult, Integer maxResults, Integer[] ids) {

		try {
			Query queryObject = sessionFactory.getCurrentSession().createQuery(hql);
			
			queryObject.setParameterList("ids", ids);
				
			if (null != firstResult && null != maxResults) {
				queryObject.setFirstResult(firstResult);
				queryObject.setMaxResults(maxResults);
			}
			return queryObject.list();
		} catch (RuntimeException re) {
			throw re;
		}
	}

	public int updateQuery(String hql, Object... params) {
		try {
			Query queryObject = sessionFactory.getCurrentSession().createQuery(hql);
			if (null != params)
				for (int i = 0; i < params.length; i++) {
					queryObject.setParameter(i, params[i]);
				}
			return queryObject.executeUpdate();
		} catch (RuntimeException re) {
			re.printStackTrace();
			return 0;
		}

	}

}
