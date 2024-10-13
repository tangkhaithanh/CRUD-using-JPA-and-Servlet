package vn.iotstar.dao.impl;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class UserDao implements IUserDao {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("dataSource");

    @Override
    public void saveUser(User user) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public User findById(Long userId) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(User.class, userId);
        } finally {
            em.close();
        }
    }

    @Override
    public User findByUsername(String username) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<User> findAllUsers() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createNamedQuery("User.findAll", User.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void updateUser(User user) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteUser(Long userId) {
        EntityManager em = emf.createEntityManager();
        try {
            User user = em.find(User.class, userId);
            if (user != null) {
                em.getTransaction().begin();
                em.remove(user);
                em.getTransaction().commit();
            }
        } finally {
            em.close();
        }
    }
}