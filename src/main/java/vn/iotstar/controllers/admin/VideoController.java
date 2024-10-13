package vn.iotstar.controllers.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
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
"/admin/video/insert", "/admin/video/add", "/admin/video/delete","/admin/video/search"})
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
            // Lấy số trang hiện tại từ request (mặc định là 0 nếu không có, tương ứng với trang 1)
            int pageNumber = 0;
            String pageStr = req.getParameter("page");
            if (pageStr != null) {
                pageNumber = Integer.parseInt(pageStr);
            }

            // Đảm bảo giá trị trang không âm
            if (pageNumber < 0) {
                pageNumber = 0;
            }

            int pageSize = 5; // Số video trên mỗi trang

            // Lấy danh sách video theo trang và số lượng video mỗi trang
            List<Video> listVideos = videoService.findAll(pageNumber, pageSize);

            // Lấy tổng số lượng video
            long totalVideos = videoService.count();
            long totalPages = (long) Math.ceil((double) totalVideos / pageSize); // Tính tổng số trang

            // Đảm bảo rằng pageNumber không lớn hơn totalPages - 1
            if (pageNumber >= totalPages && totalPages > 0) {
                pageNumber = (int) totalPages - 1;
                listVideos = videoService.findAll(pageNumber, pageSize);
            }

            // Gán các thuộc tính vào request để hiển thị trên view
            req.setAttribute("listVideos", listVideos);
            req.setAttribute("currentPage", pageNumber);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("pageSize", pageSize); // Thêm pageSize vào request attributes

            req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
        }
        else if (url.contains("/admin/video/edit")) {
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
        else if (url.contains("/admin/video/search")) {
            String keyword = req.getParameter("keyword");
            int PAGE_SIZE=5;
            // Lấy danh sách video theo từ khóa tìm kiếm
            List<Video> listVideos = videoService.searchByTitle(keyword); 

            // Cập nhật tổng số lượng video dựa trên kết quả tìm kiếm
            long totalVideos = listVideos.size(); // Lấy số lượng video từ kết quả tìm kiếm
            long totalPages = (long) Math.ceil((double) totalVideos / PAGE_SIZE); // Tính tổng số trang
            req.setAttribute("totalPages", totalPages);

            // Lấy số trang hiện tại từ tham số (nếu có), nếu không thì mặc định là 0
            String pageParam = req.getParameter("page");
            int currentPage = 0; // Mặc định là trang đầu tiên

            // Kiểm tra tham số 'page' có hợp lệ không
            try {
                if (pageParam != null) {
                    currentPage = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                // Nếu tham số không hợp lệ, giữ nguyên trang đầu tiên
                currentPage = 0;
            }

            // Đảm bảo trang hiện tại không vượt quá tổng số trang
            if (currentPage >= totalPages) {
                currentPage = (int) totalPages - 1;
            } else if (currentPage < 0) {
                currentPage = 0;
            }

            req.setAttribute("currentPage", currentPage);

            // Nếu không có video nào, không thực hiện subList
            List<Video> pagedList = new ArrayList<>();
            if (totalVideos > 0) {
                // Tính toán vị trí bắt đầu và kết thúc cho danh sách phân trang
                int start = currentPage * PAGE_SIZE; // Vị trí bắt đầu
                int end = Math.min(start + PAGE_SIZE, (int) totalVideos); // Vị trí kết thúc
                pagedList = listVideos.subList(start, end); // Lấy danh sách video phân trang
            }

            // Đưa danh sách phân trang vào request để hiển thị
            req.setAttribute("listVideos", pagedList);

            // Giữ lại tham số 'keyword' để khi chuyển trang không mất kết quả tìm kiếm
            req.setAttribute("keyword", keyword); // Để hiển thị lại từ khóa tìm kiếm trên trang

            req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
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