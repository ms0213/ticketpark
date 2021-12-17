package com.sp.tp.article;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.tp.common.FileManager;
import com.sp.tp.common.dao.CommonDAO;

@Service("article.articleService")
public class ArticleServiceImpl implements ArticleService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertArticle(Article dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("article.seq");
			dto.setArtiNum(seq);
			
			dao.insertData("article.insertArticle", dto);
			
			if(! dto.getSelectFile().isEmpty()) {
				for(MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) {
						continue;
					}
					
					dto.setSaveFilename(saveFilename);
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Article> listArticle(Map<String, Object> map) {
		List<Article> list = null;
		
		try {
			list = dao.selectList("article.listArticle", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("article.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Article readArticle(int num) {
		Article dto = null;
		try {
			dto = dao.selectOne("article.readArticle", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("article.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Article preReadArticle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Article nextReadArticle(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateArticle(Article dto, String pathname) throws Exception {
		try {
			dao.updateData("article.updateArticle", dto);
			
			if(! dto.getSelectFile().isEmpty()) {
				for(MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) {
						continue;
					}
					dto.setSaveFilename(saveFilename);
					
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteArticle(int num, String pathname, String userId, int membership) throws Exception {
		try {
			List<Article> listFile = listFile(num);
			if(listFile != null) {
				for(Article dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "artiNum");
			map.put("num", num);
			deleteFile(map);
			
			dao.deleteData("article.deleteArticle", num);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertReply(ArticleReply dto) throws Exception {
		try {
			dao.insertData("article.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<ArticleReply> listReply(Map<String, Object> map) {
			List<ArticleReply> list = null;
		
		try {
			list = dao.selectList("article.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("article.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("article.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<ArticleReply> listReplyAnswer(int answer) {
		List<ArticleReply> list = null;
		
		try {
			list = dao.selectList("article.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("article.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void insertFile(Article dto) throws Exception {
		try {
			dao.insertData("article.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Article> listFile(int num) {
		List<Article> listFile = null;
		
		try {
			listFile = dao.selectList("article.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listFile;
	}

	@Override
	public Article readFile(int fileNum) {
		Article dto = null;
		
		try {
			dto = dao.selectOne("article.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("article.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
}
