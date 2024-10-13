package vn.iotstar.service.impl;
import java.util.List;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.entity.*;
import vn.iotstar.service.IUserService;
import vn.iotstar.dao.impl.UserDao;
public class UserService implements IUserService {
	private IUserDao userDao = new UserDao();

    public User registerUser(String username, String password, String role) {
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole(role);
        newUser.setActive(1);
        userDao.saveUser(newUser);
        return newUser;
    }

    public User loginUser(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    public User findUserById(Long userId) {
        return userDao.findById(userId);
    }

    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }

    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    public void deleteUser(Long userId) {
        userDao.deleteUser(userId);
    }
}