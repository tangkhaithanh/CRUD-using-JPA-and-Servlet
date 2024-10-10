package vn.iotstar.controllers.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.CategoryService;
import vn.iotstar.service.impl.VideoService;
import vn.iotstar.utils.Constant;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = {"/admin/videos", "/admin/video/edit", "/admin/video/update",
"/admin/video/insert", "/admin/video/add", "/admin/video/delete"})
public class VideoController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IVideoService videoService = new VideoService();
    private ICategoryService categoryService = new CategoryService(); // Khởi tạo CategoryService

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("videos")) {
            List<Video> list = videoService.findAll();
            req.setAttribute("listVideos", list);
            req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/edit")) {
        	String videoId = req.getParameter("id");
            Video video = videoService.findById(videoId);
            req.setAttribute("video", video);
            
            // Lấy danh sách thể loại
            ICategoryService categoryService = new CategoryService();
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories); // Gửi danh sách thể loại đến view
            
            req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/add")) {
            // Lấy danh sách category
            ICategoryService cateService = new CategoryService();
            List<Category> categories = cateService.findAll();
            req.setAttribute("categories", categories);
            
            req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/delete")) {
            String videoId = req.getParameter("id");
            try {
                videoService.delete(videoId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/video/update")) {
            String videoId = req.getParameter("videoId");
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            int views = Integer.parseInt(req.getParameter("views"));
            int active = Integer.parseInt(req.getParameter("active"));
            String categoryId = req.getParameter("categoryId");

            // Tìm Category bằng categoryId
            Category category = categoryService.findById(Integer.parseInt(categoryId));

            // Lấy video hiện tại từ database
            Video existingVideo = videoService.findById(videoId);

            // Cập nhật thông tin video
            existingVideo.setTitle(title);
            existingVideo.setDescription(description);
            existingVideo.setViews(views);
            existingVideo.setActive(active);
            existingVideo.setCategory(category);

            // Xử lý hình ảnh (nếu có)
            String uploadPath = Constant.UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            try {
                Part part = req.getPart("poster");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);

                    // Xóa file cũ nếu có
                    if (existingVideo.getPoster() != null && !existingVideo.getPoster().isEmpty()) {
                        File oldFile = new File(uploadPath + "/" + existingVideo.getPoster());
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }

                    existingVideo.setPoster(fname);
                }
                // Nếu không có file mới, giữ nguyên poster cũ
            } catch (Exception e) {
                e.printStackTrace();
                // Xử lý lỗi, có thể thêm thông báo lỗi cho người dùng
            }

            videoService.update(existingVideo);
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
        else if (url.contains("/admin/video/insert")) {
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            int views = Integer.parseInt(req.getParameter("views"));
            int active = Integer.parseInt(req.getParameter("active"));
            String categoryIdStr = req.getParameter("categoryId"); // Nhận id từ form

            if (categoryIdStr == null || categoryIdStr.isEmpty()) {
                // Xử lý lỗi
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing category ID");
                return;
            }

            int categoryId1 = Integer.parseInt(categoryIdStr); // Chuyển đổi sang số
            Category category = categoryService.findById(categoryId1); // Tìm category bằng ID

            Video video = new Video();
            video.setTitle(title);
            video.setDescription(description);
            video.setViews(views);
            video.setActive(active);
            video.setCategory(category); // Thiết lập category cho video

            // Xử lý hình ảnh
            String fname = "";
            String uploadPath = Constant.UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            try {
                Part part = req.getPart("poster");
                if (part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    // Đổi tên file
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    // Upload file
                    part.write(uploadPath + "/" + fname);
                    // Ghi tên file vào data
                    video.setPoster(fname);
                } else {
                    video.setPoster("default_poster.png"); // Giá trị mặc định nếu không có file upload
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            videoService.insert(video); // Gọi phương thức insert
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }
}
