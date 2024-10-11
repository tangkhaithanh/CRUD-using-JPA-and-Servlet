package vn.iotstar.dao.impl;
import java.util.List;

import jakarta.persistence.EntityManager;


import jakarta.persistence.EntityTransaction;


import jakarta.persistence.Query;


import jakarta.persistence.TypedQuery;


import vn.iotstar.configs.JPAConfig;


import vn.iotstar.dao.ICategoryDao;


import vn.iotstar.entity.Category;
public class CategoryDao implements ICategoryDao{
	
	@Override
	public void insert(Category category)
	{
		EntityManager enma= JPAConfig.getEntityManager();
		EntityTransaction trans=enma.getTransaction();
		try {
			trans.begin();
			enma.persist(category);
			trans.commit();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			trans.rollback();
			throw e;
		}
		finally
		{
			enma.close();
		}
		
	}
	@Override
	public void update(Category category) {
	    EntityManager enma = JPAConfig.getEntityManager();
	    EntityTransaction trans = enma.getTransaction();

	    try {
	        trans.begin();

	        // Gọi phương thức để insert, update, delete
	        enma.merge(category);

	        trans.commit();
	    } catch (Exception e) {
	        e.printStackTrace();
	        trans.rollback();
	        throw e;
	    } finally {
	        enma.close();
	    }
	}
	@Override
	public void delete(int cateid) throws Exception {
	    EntityManager enma = JPAConfig.getEntityManager();
	    EntityTransaction trans = enma.getTransaction();

	    try {
	        trans.begin();

	        // Gọi phương thức để insert, update, delete
	        Category category = enma.find(Category.class, cateid);

	        if (category != null) {
	            enma.remove(category);
	        } else {
	            throw new Exception("Không tìm thấy");
	        }

	        trans.commit();
	    } catch (Exception e) {
	        e.printStackTrace();
	        trans.rollback();
	        throw e;
	    } finally {
	        enma.close();
	    }
	}
	 @Override
	public Category findById(int cateid) {

		 EntityManager enma = JPAConfig.getEntityManager();

		 Category category = enma.find(Category.class,cateid);
		 return category;
	}
	 
	 @Override
	public List<Category> findAll() {
		 EntityManager enma = JPAConfig.getEntityManager();

		 TypedQuery<Category> query= enma.createNamedQuery("Category.findAll", Category.class);

		 return query.getResultList();
	}

	// Tim kiem theo ten:
	 @Override
	public List<Category> findByCategoryname(String catname) 
	 {

		 EntityManager enma = JPAConfig.getEntityManager();
		 
		 String jpql = "SELECT c FROM Category c WHERE c.catename like :catname";

		 TypedQuery<Category> query= enma.createQuery(jpql, Category.class);

		 query.setParameter("catename", "%" + catname + "%");

		 return query.getResultList();

	}
	
	 // FindAll phan trang:
	 @Override
	 public List<Category> findAll(int page, int pageSize) {
		    EntityManager enma = JPAConfig.getEntityManager();
		    
		    // Đảm bảo page không âm
		    if (page < 0) {
		        page = 0;
		    }
		    
		    TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
		    
		    // Đảm bảo giá trị firstResult không âm
		    int firstResult = Math.max(page * pageSize, 0);
		    
		    query.setFirstResult(firstResult);  // Thiết lập vị trí bắt đầu
		    query.setMaxResults(pageSize);      // Giới hạn số lượng kết quả
		    
		    return query.getResultList();
		}

	 @Override
	public int count()
	 {


		 EntityManager enma = JPAConfig.getEntityManager();

		 String jpql = "SELECT count(c) FROM Category c";

		 Query query = enma.createQuery(jpql);

		 return ((Long)query.getSingleResult()).intValue();

	}
	


}
