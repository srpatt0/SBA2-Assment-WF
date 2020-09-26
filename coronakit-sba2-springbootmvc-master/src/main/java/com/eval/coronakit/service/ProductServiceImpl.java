package com.eval.coronakit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eval.coronakit.dao.ProductMasterRepository;
import com.eval.coronakit.entity.ProductMaster;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductMasterRepository repository;
	
	@Override
	public ProductMaster addNewProduct(ProductMaster product) {
		ProductMaster prod =repository.save(product);
		return prod;
	}

	@Override
	public List<ProductMaster> getAllProducts() {
		List<ProductMaster> prods =repository.findAll();
		return prods;
	}

	@Override
	public ProductMaster deleteProduct(int productId) {
		
		Optional <ProductMaster> product = repository.findById(productId);
		if (product.isPresent())
		{
			repository.deleteById(productId);
			return product.get();
			
		}else {
			
		}
	
		return product.get();
	}

	@Override
	public ProductMaster getProductById(int productId) {
		Optional<ProductMaster> prod =repository.findById(productId);
		return prod.get();
	}

}
