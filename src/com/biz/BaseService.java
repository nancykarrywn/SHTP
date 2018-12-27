package com.biz;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.BaseDao;
//业务逻辑层接口
//注入所有的DAO接口
@Service
@Transactional
public class BaseService<T, PK> {

	@Autowired
	private BaseDao<T, PK> baseDao;

	public void save(T t) {
		baseDao.save(t);
	}

	public void delete(T t) {
		baseDao.delete(t);
	}

	public void delById(Class<T> t, Integer pk) {
		baseDao.delById(t, pk);
	}

	public void update(T t) {
		baseDao.update(t);
	}

	public T findById(Class<T> t, Integer pk) {
		return baseDao.findById(t, pk);
	}

	@SuppressWarnings("unchecked")//消除警告
	public List<T> findByExample(T t) {
		return baseDao.findByExample(t);
	}

	@SuppressWarnings("unchecked")
	public List<T> findByProperty(T t, String propertyName, T value) {
		return baseDao.findByProperty(t, propertyName, value);
	}

	@SuppressWarnings("unchecked")
	public List<T> findAll(String modelName) {
		return baseDao.findAll(modelName);
	}

	public T merge(T detachedInstance) {
		return baseDao.merge(detachedInstance);
	}

	public void attachDirty(T instance) {
		baseDao.attachDirty(instance);
	}

	public void attachClean(T instance) {
		baseDao.attachClean(instance);
	}

	public T uniqueQuery(String hql, Object... parameters) {
		return baseDao.uniqueQuery(hql, parameters);
	}

	public List<T> getResult(String hql, Object... parameters) {
		return baseDao.getResult(hql, parameters);
	}

	public List<T> pageQuery(String hql, Integer firstResult, Integer maxResults, Object... params) {
		return baseDao.pageQuery(hql, firstResult, maxResults, params);
	}
	
	public List<T> pageQuerys(String hql, Integer firstResult, Integer maxResults, Integer[] params) {
		return baseDao.pageQuerys(hql, firstResult, maxResults, params);
	}

	public int updateQuery(String hql, Object... params) {
		return baseDao.updateQuery(hql, params);
	}

	public Serializable saveR(T t) {
		return baseDao.saveR(t);
	}

}
