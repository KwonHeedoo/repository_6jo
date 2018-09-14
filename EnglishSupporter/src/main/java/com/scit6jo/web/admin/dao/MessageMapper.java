package com.scit6jo.web.admin.dao;

import java.util.ArrayList;

import com.scit6jo.web.admin.vo.Message;

public interface MessageMapper {
	// 읽지 않은 쪽지 요청
	public ArrayList<Message> unReadMsg(String receiveid);
	// 모든 쪽지 리스트 요청
	public ArrayList<Message> selectAll(String receiveid);
	// 쪽지 보내기
	public int sendMsg(Message message);
	// 쪽지 읽음 처리
	public int readMsg(int messageNum);
	
}
