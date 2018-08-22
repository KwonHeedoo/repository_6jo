package com.scit6jo.web.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

<<<<<<< HEAD
@Repository
public class UserRepository {
	@Autowired
	SqlSession session;
}

=======
import com.scit6jo.web.vo.User;

@Repository
public class UserRepository {
	
	@Autowired
	SqlSession session;
	
	public User selectOne(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User u = mapper.selectOne(user);
	
		return u;
	}
	
	public int attendNum(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = mapper.attendNum(user);
		
		return result; 
	}
}
>>>>>>> 80812f0b683718742dd892a693fc448feb7478bb
