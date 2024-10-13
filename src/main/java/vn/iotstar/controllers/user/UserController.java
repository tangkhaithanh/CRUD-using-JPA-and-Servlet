package vn.iotstar.controllers.user;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/user/register", "/user/login", "/user/logout"})
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
    {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/user/register")) {
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        } else if (url.contains("/user/login")) {
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else if (url.contains("/user/logout")) 
        {
            HttpSession session = req.getSession();
            session.invalidate(); // Hủy session hiện tại khi logout
            resp.sendRedirect(req.getContextPath() + "/user/login");
        }
   }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/user/register")) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String role = "USER";
            userService.registerUser(username, password, role);
            resp.sendRedirect(req.getContextPath() + "/user/login");
        } else if (url.contains("/user/login")) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            User user = userService.loginUser(username, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                if ("ADMIN".equals(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/admin/videos");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/home");
                }
            } else {
                req.setAttribute("errorMessage", "Tên người dùng hoặc mật khẩu không đúng");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            }
        }
    }
}