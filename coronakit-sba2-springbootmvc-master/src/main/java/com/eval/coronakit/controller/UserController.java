package com.eval.coronakit.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.eval.coronakit.entity.CoronaKit;
import com.eval.coronakit.entity.KitDetail;
import com.eval.coronakit.entity.ProductMaster;
import com.eval.coronakit.service.CoronaKitService;
import com.eval.coronakit.service.KitDetailService;
import com.eval.coronakit.service.ProductService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	ProductService productService;
	
	@Autowired
	CoronaKitService coronaKitService;

	@Autowired
	KitDetailService kitDetailService;

	HttpSession session;
	
	@RequestMapping("/home")
	public String home() {

		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		session = attr.getRequest().getSession();		
		List<ProductMaster> products = productService.getAllProducts();
		session.setAttribute("productsCatalog", products);

		if (session.getAttribute("firstTime") == null)
			session.setAttribute("firstTime", "yes");		
		return "user-home";
	}

	@RequestMapping("/show-kit")
	public String showKit(Model model) {
		return "show-cart";
	}

	@RequestMapping("/show-list")
	public String showList(Model model) {
		@SuppressWarnings("unchecked")
		List<ProductMaster> products = (List<ProductMaster>)session.getAttribute("productsCatalog");
		model.addAttribute("productList", products);
		return "show-all-item-user";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/add-to-cart/{productId}")
	public String showKit(@PathVariable("productId") int productId, Model model) {

		List<ProductMaster> products = (List<ProductMaster>)session.getAttribute("productsCatalog");
		List<KitDetail> kitList=new ArrayList<KitDetail>();
		List<String[]> cartList;
		String[] strArr = new String[4];
		KitDetail kitdetail,temp;
		ProductMaster product = null;
		Map<Integer, String> productMap = products.stream()
				.collect(Collectors.toMap(x -> x.getId(), x -> x.getProductName()));
		
		for(ProductMaster desProduct:products)
		{
			if(desProduct.getId()==productId) {
				product=desProduct;
				break;
			}
		}
		
		if (session.getAttribute("firstTime").toString().equals("yes")) {
			kitdetail = new KitDetail();
			kitdetail.setAmount(product.getCost());			
			kitdetail.setProductId(productId);
			kitdetail.setQuantity(1);
			kitdetail.setId(kitList.size()+1);
			kitList.add(kitdetail);
			session.setAttribute("kitsCatalogue", kitList);
			session.setAttribute("firstTime", "no");
		} else {
			
			kitList = (List<KitDetail>)session.getAttribute("kitsCatalogue");

			for (KitDetail kit : kitList) {
				if (kit.getProductId() == productId) {
					
					temp=kit;
					kitList.remove(kit);
					temp.setQuantity(kit.getQuantity() + 1);
					temp.setAmount(kit.getAmount() + product.getCost());
					kitList.add(temp);					
					cartList = new ArrayList<String[]>();
					for (KitDetail kd : kitList) {
						strArr = new String[4];
						strArr[0] = productMap.get(kd.getProductId());
						strArr[1] = String.valueOf(kd.getQuantity());
						strArr[2] = String.valueOf(kd.getAmount());
						strArr[3] = String.valueOf(kd.getId());
						cartList.add(strArr);
					}
					model.addAttribute("cartList", cartList);
					session.setAttribute("kitsCatalogue", kitList);
					return "show-cart";
				}
			}
			kitdetail = new KitDetail();
			kitdetail.setAmount(product.getCost());
			kitdetail.setProductId(productId);
			kitdetail.setQuantity(1);
			kitdetail.setId(kitList.size()+1);			
			kitList.add(kitdetail);
			session.setAttribute("kitsCatalogue", kitList);
			

		}
		
		cartList = new ArrayList<String[]>();
		
		for (KitDetail kd : kitList) {
			strArr = new String[4];
			strArr[0] = productMap.get(kd.getProductId());
			strArr[1] = String.valueOf(kd.getQuantity());
			strArr[2] = String.valueOf(kd.getAmount());
			strArr[3] = String.valueOf(kd.getId());
			cartList.add(strArr);
		}
		model.addAttribute("cartList", cartList);
		return "show-cart";
	}

	@RequestMapping("/checkout")
	public String checkout(Model model) {

		
		CoronaKit ck =new CoronaKit();
		@SuppressWarnings("unchecked")
		List<KitDetail> kitList = (List<KitDetail>)session.getAttribute("kitsCatalogue");
		ck.setOrderDate(LocalDate.now().toString());
		int totAmt = 0;
		
		for (KitDetail kd : kitList)
			totAmt += kd.getAmount();
		ck.setTotalAmount(totAmt);		
		model.addAttribute("ck", ck);		
		session.setAttribute("coronaKit", ck);
		return "checkout-address";
	}

	@RequestMapping("/finalize")
	public String finalizeOrder(@Valid @ModelAttribute ("ck") CoronaKit coronakit,BindingResult result, Model model) {
		
		if(result.hasErrors())
		{
			return "checkout-address";
		}

		int coronakitid;
		CoronaKit finalKit = (CoronaKit)session.getAttribute("coronaKit");
		finalKit.setDeliveryAddress(coronakit.getDeliveryAddress());
		coronaKitService.saveKit(finalKit);
		int i = 1;
		@SuppressWarnings("unchecked")
		List<KitDetail> kitList= (List<KitDetail>)session.getAttribute("kitsCatalogue");
		@SuppressWarnings("unchecked")
		List<ProductMaster> products = (List<ProductMaster>)session.getAttribute("productsCatalog");
		List<String[]> cartList;
		String[] strArr = new String[4];

		Map<Integer, String> productMap = products.stream()
				.collect(Collectors.toMap(product -> product.getId(), product -> product.getProductName()));
		
		cartList = new ArrayList<String[]>();
		for (KitDetail kd : kitList) {
			strArr = new String[4];
			strArr[0] = String.valueOf(i);
			strArr[1] = productMap.get(kd.getProductId());
			strArr[2] = String.valueOf(kd.getQuantity());
			strArr[3] = String.valueOf(kd.getAmount());
			cartList.add(strArr);
			i++;
		}
		model.addAttribute("address", coronakit.getDeliveryAddress());
		model.addAttribute("date", finalKit.getOrderDate());
		model.addAttribute("amount", finalKit.getTotalAmount());
		model.addAttribute("cartList", cartList);
		
		coronakitid=coronaKitService.getCurrrentId();
		for(KitDetail dbKit:kitList)
		{
			dbKit.setCoronaKitId(coronakitid);
			dbKit.setId(0);
			kitDetailService.addKitItem(dbKit);
		}
		return "show-summary";
	}

	@RequestMapping("/delete/{itemId}")
	public String deleteItem(@PathVariable("itemId") int itemId, Model model) {
		
		@SuppressWarnings("unchecked")
		List<KitDetail> kitList = (List<KitDetail>)session.getAttribute("kitsCatalogue");
		@SuppressWarnings("unchecked")
		List<ProductMaster> products = (List<ProductMaster>)session.getAttribute("productsCatalog");
		for(KitDetail kitdetail:kitList)
		{
			if(kitdetail.getId()==itemId)
			{
				kitList.remove(kitdetail);
				break;
			}
		}
		if(kitList.size()<=0)
		{
			return "redirect:/user/show-list";
		}
				
		List<String[]> cartList;
		String[] strArr = new String[4];		

		Map<Integer, String> productMap = products.stream()
				.collect(Collectors.toMap(product -> product.getId(), product -> product.getProductName()));
		
		cartList = new ArrayList<String[]>();
		for (KitDetail kd : kitList) {
			strArr = new String[4];
			strArr[0] = productMap.get(kd.getProductId());
			strArr[1] = String.valueOf(kd.getQuantity());
			strArr[2] = String.valueOf(kd.getAmount());
			strArr[3] = String.valueOf(kd.getId());
			cartList.add(strArr);
		}
		
		model.addAttribute("cartList", cartList);
		session.setAttribute("kitsCatalogue", kitList);
		return "show-cart";
	}
}