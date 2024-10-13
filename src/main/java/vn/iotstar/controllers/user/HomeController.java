package vn.iotstar.controllers.user;

import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.VideoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/home", "/home/search"})
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IVideoService videoService = new VideoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/home/search")) {
            handleSearch(req, resp);
        } else if (url.contains("/home")) {
            handleHome(req, resp);
        }
    }

    private void handleHome(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNumber = 0;
        String pageStr = req.getParameter("page");
        if (pageStr != null) {
            pageNumber = Integer.parseInt(pageStr);
        }
        
        int pageSize = 5;
        List<Video> listVideos = videoService.findAll(pageNumber, pageSize);
        long totalVideos = videoService.count();
        long totalPages = (long) Math.ceil((double) totalVideos / pageSize);

        req.setAttribute("listVideos", listVideos);
        req.setAttribute("currentPage", pageNumber);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }

    private void handleSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        int PAGE_SIZE = 5;

        List<Video> listVideos = videoService.searchByTitle(keyword);
        long totalVideos = listVideos.size();
        long totalPages = (long) Math.ceil((double) totalVideos / PAGE_SIZE);

        String pageParam = req.getParameter("page");
        int currentPage = 0;

        try {
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            currentPage = 0;
        }

        if (currentPage >= totalPages) {
            currentPage = (int) totalPages - 1;
        } else if (currentPage < 0) {
            currentPage = 0;
        }

        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);

        List<Video> pagedList = new ArrayList<>();
        if (totalVideos > 0) {
            int start = currentPage * PAGE_SIZE;
            int end = Math.min(start + PAGE_SIZE, (int) totalVideos);
            pagedList = listVideos.subList(start, end);
        }

        req.setAttribute("listVideos", pagedList);
        req.setAttribute("keyword", keyword);

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}