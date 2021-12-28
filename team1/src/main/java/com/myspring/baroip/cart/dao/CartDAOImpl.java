package com.myspring.baroip.cart.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.baroip.cart.vo.CartVO;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO{
	@Autowired
	private SqlSession sqlSession;
	
//	장바구니 페이지
	@Override
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
		List<CartVO> cartList = sqlSession.selectList("mapper.cart.selectCartList", cartVO);
		return cartList;
	}
	
//	상품 상세 페이지 > 장바구니 담기 기능
	@Override
	public void insertProductInCart(CartVO cartVO) throws DataAccessException {
		sqlSession.insert("mapper.cart.insertProductInCart", cartVO);
	}

}
