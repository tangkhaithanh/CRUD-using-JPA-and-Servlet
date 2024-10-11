package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.impl.VideoDao;
import vn.iotstar.dao.IVideoDao;
import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;

public class VideoService implements IVideoService{

	private IVideoDao videoDao = new VideoDao();
	@Override
	public void insert(Video video) {
		// TODO Auto-generated method stub
		videoDao.insert(video);
	}

	@Override
	public void update(Video video) {
		// TODO Auto-generated method stub
		videoDao.update(video);
		
	}

	@Override
	public void delete(String videoId) throws Exception {
		// TODO Auto-generated method stub
		videoDao.delete(videoId);
		
	}

	@Override
	public Video findById(String videoId) {
		// TODO Auto-generated method stub
		return videoDao.findById(videoId);
	}

	@Override
	public List<Video> findAll() {
		// TODO Auto-generated method stub
		return videoDao.findAll();
	}

	@Override
	public List<Video> findByTitle(String title) {
		// TODO Auto-generated method stub
		return videoDao.findByTitle(title);
	}

	@Override
	public List<Video> findAll(int page, int pageSize) {
		// TODO Auto-generated method stub
		return videoDao.findAll(page,pageSize);
	}

	@Override
	public int count() {
		// TODO Auto-generated method stub
		return videoDao.count();
	}

	@Override
	public List<Video> searchByTitle(String title)
	{
		    return videoDao.searchByTitle(title);
	}
}
