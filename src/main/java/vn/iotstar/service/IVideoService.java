package vn.iotstar.service;

import java.util.List;

import vn.iotstar.entity.Video;

public interface IVideoService {
	// Thêm mới một video
    void insert(Video video);
    
    // Cập nhật thông tin của video
    void update(Video video);
    
    // Xóa video theo ID
    void delete(String videoId) throws Exception;
    
    // Tìm video theo ID
    Video findById(String videoId);
    
    // Lấy danh sách tất cả các video
    List<Video> findAll();
    
    // Tìm kiếm video theo tiêu đề
    List<Video> findByTitle(String title);
    
    // Phân trang cho danh sách video
    List<Video> findAll(int page, int pageSize);
    
    // Đếm tổng số video
    int count();
    
    List<Video> searchByTitle(String title);
}
