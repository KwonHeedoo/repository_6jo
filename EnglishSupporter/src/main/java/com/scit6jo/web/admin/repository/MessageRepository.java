package com.scit6jo.web.admin.repository;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.admin.dao.MessageMapper;
import com.scit6jo.web.admin.vo.Message;

@Repository
public class MessageRepository {
	@Autowired
	SqlSession session;
	
	// 읽지 않은 메세지 요청
	public ArrayList<Message> unReadMsg(String receiveid) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		ArrayList<Message> messageList = null;
		
		try {
			messageList = mapper.unReadMsg(receiveid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return messageList;
	}
	
	// 모든 메세지 리스트 요청
	public ArrayList<Message> selectAll(String receiveid) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		ArrayList<Message> messageList = null;
		
		try {
			messageList = mapper.selectAll(receiveid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return messageList;
	}
	
	// 메세지 보내기
	public int sendMsg(Message message) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = 0;
		
		try {
			result = mapper.sendMsg(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 메세지 읽음 처리
	public int readMsg(int messageNum) {
		MessageMapper mapper = session.getMapper(MessageMapper.class);
		int result = 0;
		
		try {
			result = mapper.readMsg(messageNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
