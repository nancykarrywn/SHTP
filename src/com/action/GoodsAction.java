package com.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ExceptionMapping;
import org.apache.struts2.convention.annotation.ExceptionMappings;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.biz.BaseService;
import com.entity.AuditedGoods;
import com.entity.Category;
import com.entity.Goods;
import com.entity.Member;
import com.entity.Orders;
import com.utils.Page;

@Controller
@Scope("prototype")
@Namespace("/goods")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class GoodsAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private BaseService<AuditedGoods, Integer> auditedgoodsService;
	@Autowired
	private BaseService<Goods, Integer> goodsService;
	@Autowired
	private BaseService<Member, Integer> memberService;
	@Autowired
	private BaseService<Category, Integer> categoryService;
	@Autowired
	private BaseService<Orders, Integer> ordersService;
	
	private AuditedGoods auditedgoods;

	private Goods goods;
	
	private List<AuditedGoods> auditedgoodsList;

	private List<Goods> goodsList;

	private String message;
	
	private String fileFileName;

	private File file;
	
	public AuditedGoods getAuditedgoods() {
		return auditedgoods;
	}

	public void setAuditedgoods(AuditedGoods auditedgoods) {
		this.auditedgoods = auditedgoods;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	
	public List<AuditedGoods> getAuditedgoodsList() {
		return auditedgoodsList;
	}

	public void setAuditedgoodsList(List<AuditedGoods> auditedgoodsList) {
		this.auditedgoodsList = auditedgoodsList;
	}

	public List<Goods> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}
	
    //妫ｆ牠銆夐惃鍕櫌閸濅焦甯归懡鎰櫕闂堬拷
	
	@Action(value = "recommend", results = {
			@Result(name = "recommend", location = "/WEB-INF/mall/business/goods.jsp") })
	public String recommend() {
		String pageNoStr = request.getParameter("pageNo");
		int pageNo, pageSize;
		if (null == pageNoStr)
			pageNo = 1;
		else
			pageNo = Integer.valueOf(pageNoStr);
		String pageSizeStr = request.getParameter("pageSize");
		if (null == pageSizeStr)
			pageSize = 8;
		else
			pageSize = Integer.valueOf(pageSizeStr);
		int firstResult = (pageNo - 1) * pageSize;
		Page page = Page.newBuilder(pageNo, pageSize, "recommend.action");
		page.setTotalRecord(goodsService.getResult("from Goods where isRecommend = 1 and isChecked = 1").size());
		request.setAttribute("page", page);
		goodsList = goodsService.pageQuery("from Goods where isRecommend = 1 and isChecked = 1", firstResult, pageSize);
		return "recommend";
	}
	//缁狅紕鎮婇崨妯煎仯閸戠粯甯归懡鎰吀閻烇拷
	
	@Action(value = "recommend1", results = {
			@Result(name = "recommend1", location = "/WEB-INF/admin/goods/recommend.jsp") })
	public String recommend1() {
		String pageNoStr = request.getParameter("pageNo");
		int pageNo, pageSize;
		if (null == pageNoStr)
			pageNo = 1;
		else
			pageNo = Integer.valueOf(pageNoStr);
		String pageSizeStr = request.getParameter("pageSize");
		if (null == pageSizeStr)
			pageSize = 8;
		else
			pageSize = Integer.valueOf(pageSizeStr);
		int firstResult = (pageNo - 1) * pageSize;
		Page page = Page.newBuilder(pageNo, pageSize, "recommend.action");
		page.setTotalRecord(goodsService.getResult("from Goods where isRecommend = 1 and isChecked = 1").size());
		request.setAttribute("page", page);
		goodsList = goodsService.pageQuery("from Goods where isRecommend = 1 and isChecked = 1", firstResult, pageSize);
		return "recommend1";
	}
   //鐠佸墽鐤嗛崯鍡楁惂娑撶儤甯归懡鎰櫌閸濓拷
	@Action(value = "recommended", results = { @Result(name = "recommended", type = "json") })
	public String recommended() {
		goods = goodsService.findById(Goods.class, goods.getId());
		goods.setIsChecked("1");
		goods.setIsRecommend("1");
		goodsService.update(goods);
		setMessage("success");
		return "recommended";
	}
    //閸欐牗绉烽幒銊ㄥ礃
	@Action(value = "cancelRecommend", results = { @Result(name = "cancelRecommend", type = "json") })
	public String cancelRecommend() {
		goods = goodsService.findById(Goods.class, goods.getId());
		goods.setIsRecommend("0");
		goodsService.update(goods);
		setMessage("success");
		return "cancelRecommend";
	}
	
	

	@Action(value = "toInsert", results = { @Result(name = "toInsert", location = "/WEB-INF/admin/goods/insert.jsp") })
	public String toInsert() {
		return "toInsert";
	}

	@Action(value = "insert", results = { @Result(name = "insert", type = "json") })
	public String insert() {
		goodsService.save(goods);
		setMessage("success");
		return "insert";
	}
    /*
	@Action(value = "toUpdate", results = { @Result(name = "toUpdate", location = "/WEB-INF/admin/goods/update.jsp") })
	public String toUpdate() {
		return "toUpdate";
	}
	*/

    //閸忔娊鏁�妤佹偝缁憋拷
	@Action(value = "searchByName", results = {
			@Result(name = "searchByName", location = "/WEB-INF/mall/business/goods.jsp") })
	public String searchByName() {
		String pageNoStr = request.getParameter("pageNo");
		int pageNo, pageSize;
		if (null == pageNoStr)
			pageNo = 1;
		else
			pageNo = Integer.valueOf(pageNoStr);
		String pageSizeStr = request.getParameter("pageSize");
		if (null == pageSizeStr)
			pageSize = 8;
		else
			pageSize = Integer.valueOf(pageSizeStr);
		int firstResult = (pageNo - 1) * pageSize;
		Page page = Page.newBuilder(pageNo, pageSize, "list.action");
		page.setTotalRecord(goodsService.getResult("from Goods where name like ? and isChecked = 1", "%"+goods.getName()+"%").size());
		goodsList = goodsService.pageQuery("from Goods where name like ? and isChecked = 1", firstResult, pageSize, "%"+goods.getName()+"%");
		request.setAttribute("page", page);
		return "searchByName";
	}
	
	//鐢ㄦ埛鐐瑰嚮杩涘叆鏌ョ湅鍟嗗搧璇︽儏
	@Action(value = "goodsInfo", results = { @Result(name = "goodsInfo", location = "/WEB-INF/mall/goods/goodsInfo.jsp") })
	public String goodsInfo() {
		goods = goodsService.findById(Goods.class, goods.getId());
		return "goodsInfo";
	}
	
	/*
	 * 閻€劍鍩涢崣鎴濈閸熷棗鎼�
	 * */
	//鐢ㄦ埛鏌ョ湅宸插彂甯冨晢鍝佸垪琛�
	@Action(value = "publishedGoods", results = { @Result(name = "publishedGoods", location = "/WEB-INF/mall/goods/publishedGoods.jsp") })
	public String publishedGoods(){
		Member mem = (Member) session.getAttribute("loginMember");
		Member member = memberService.findById(Member.class, mem.getId());
		Set<Goods> myGoods = member.getGoods();
		request.setAttribute("myGoods", myGoods);
		return "publishedGoods";
	}
	
	//閻€劍鍩涢悙鐟板毊閳ユ粌褰傜敮鍐ㄦ櫌閸濅讲锟� 閺勫墽銇氱憰浣革綖閸愭瑧娈戦崯鍡楁惂娣団剝浼�
	@Action(value = "toPublish", results = { @Result(name = "toPublish", location = "/WEB-INF/mall/goods/publish.jsp") })
	public String toPublish() {
		List<Category> categoryList = categoryService.pageQuery("from Category", null, null);
		request.setAttribute("categoryList", categoryList);
		return "toPublish";
	}
	
	//娑擃亙姹夋稉顓炵妇-瀹告彃褰傜敮鍐ㄦ櫌閸濓拷閻€劍鍩涢崣鎴濈閺傛澘鏅㈤崫锟�
	@Action(value = "publishNew", interceptorRefs = {
			@InterceptorRef(value = "fileUploadStack", params = { "allowedTypes",
					"image/bmp,image/png,image/gif,image/pjpeg,image/jpg", "maximumSize", "10485760" }),
			@InterceptorRef("defaultStack") }, results = { @Result(name = "publishNew", type = "chain", params = {
					"namespace", "/goods", "actionName", "publishedGoods" }) })
	public String publishNew(){
		@SuppressWarnings("deprecation")//閹舵垶顒涙潻鍥ㄦ閻ㄥ嫯顒熼崨锟�
		String root = request.getRealPath("/upload");
		//goods.setIsRecommend("0");
		//goods.setIsChecked("0");
		auditedgoods.setState("0");
		auditedgoods.setIsRecommend("0");
		auditedgoods.setMember((Member) session.getAttribute("loginMember"));
		if (null != file)
			try {
				
				//鐠囪褰囬弬鍥︽
				InputStream is = new FileInputStream(file);
				// 瀵版鍩岄崶鍓у娣囨繂鐡ㄩ惃鍕秴缂冿拷閺嶈宓乺oot閺夈儱绶遍崚鏉挎禈閻楀洣绻氱�妯兼畱鐠侯垰绶為崷鈺皁mcat娑撳娈戠拠銉ヤ紣缁嬪鍣�
				String prefix = String.valueOf(new Date().getTime());
				//閸掓稑缂揻ile鐎电钖� 閸︹暜oot娑擄拷
				File destFile = new File(root, prefix + fileFileName);
				String path = "/SHTP/upload/" + prefix + fileFileName;
				// 閹跺﹤娴橀悧鍥у晸閸忋儱鍩屾稉濠囨桨鐠佸墽鐤嗛惃鍕熅瀵板嫰鍣�
				OutputStream os = new FileOutputStream(destFile);
				//fs.length=1024 os.write閸愭瑥鍙嗙�妤冾儊娑撴彃鍩岄弬鍥︽閹诲繗鍫粭锔胯厬
				byte[] buffer = new byte[1024];
				int length = 0;
				while ((length = is.read(buffer)) > 0) {
					os.write(buffer, 0, length);
				}
				is.close();
				os.close();
				auditedgoods.setImg(path);
				auditedgoodsService.save(auditedgoods);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return "publishNew";
	}
	
	/*
	 * 绠＄悊鍛樺鏍�
	 * */
	//绠＄悊鍛樻煡鐪嬪緟瀹℃牳鍟嗗搧鍒楄〃
	@Action(value = "list", results = { @Result(name = "index", location = "/WEB-INF/admin/goods/index.jsp") })
	public String list() {
		String pageNoStr = request.getParameter("pageNo");
		int pageNo, pageSize;
		if (null == pageNoStr)
			pageNo = 1;
		else
			pageNo = Integer.valueOf(pageNoStr);
		String pageSizeStr = request.getParameter("pageSize");
		if (null == pageSizeStr)
			pageSize = 8;
		else
			pageSize = Integer.valueOf(pageSizeStr);
		int firstResult = (pageNo - 1) * pageSize;
		Page page = Page.newBuilder(pageNo, pageSize, "list.action");
		page.setTotalRecord(auditedgoodsService.getResult("from AuditedGoods").size());
		request.setAttribute("page", page);
		auditedgoodsList = auditedgoodsService.pageQuery("from AuditedGoods", firstResult, pageSize);
		return "index";
	}
	//绠＄悊鍛樼偣鍑绘煡鐪嬪緟瀹℃牳鍟嗗搧璇︾粏淇℃伅
	@Action(value = "info", results = { @Result(name = "info", location = "/WEB-INF/admin/goods/info.jsp") })
	public String info() {
		auditedgoods = auditedgoodsService.findById(AuditedGoods.class, auditedgoods.getId());
		return "info";
	}
	//瀹℃牳閫氳繃
	@Action(value = "checked", results = { @Result(name = "checked", type = "json") })
	public String checked() {
		
		System.out.println("瀹℃牳瀹℃牳瀹℃牳閫氳繃");
		
		auditedgoods = auditedgoodsService.findById(AuditedGoods.class, auditedgoods.getId());
		
		
		goods.setName(auditedgoods.getName());
		goods.setPrice(auditedgoods.getPrice());
		goods.setImg(auditedgoods.getImg());
		goods.setIntro(auditedgoods.getIntro());
		goods.setIsChecked("1");		
		goodsService.update(goods);
		auditedgoodsService.delete(auditedgoods);
		
		setMessage("success");
		return "checked";
	}
	//瀹℃牳涓嶉�杩�
	@Action(value = "cancelChecked", results = { @Result(name = "cancelChecked", type = "json") })
	public String cancelChecked() {
		goods = goodsService.findById(Goods.class, goods.getId());				
		goodsService.delete(goods);
		setMessage("success");
		return "cancelChecked";
	}
	//绠＄悊鍛樺垹闄ゅ晢鍝�
	@Action(value = "delaudited", results = { @Result(name = "delaudited", type = "json") })
	public String dela() {
		//System.out.println("绠＄悊鍛樺垹闄ゅ晢鍝�);
		auditedgoods = auditedgoodsService.findById(AuditedGoods.class, auditedgoods.getId());
		auditedgoodsService.delete(auditedgoods);
		setMessage("success");
		return "delaudited";
	}
	
	/*
	 * 鍟嗗搧淇℃伅绠＄悊
	 * */
	//鐢ㄦ埛鏌ョ湅宸插彂甯冨晢鍝佺殑璇︾粏淇℃伅
	@Action(value = "publishedInfo", results = { @Result(name = "publishedInfo", location = "/WEB-INF/mall/goods/publishedInfo.jsp") })
	public String publishedInfo(){
		goods = goodsService.findById(Goods.class, goods.getId());
		return "publishedInfo";
	}
	
	//鍒犻櫎鍟嗗搧
	@Action(value = "del", results = { @Result(name = "del", type = "json") })
	public String del() {
		System.out.println("鍒犻櫎宸茬粡鍙戝竷鐨勫晢鍝�");
		goods = goodsService.findById(Goods.class, goods.getId());
		goodsService.delete(goods);
		setMessage("success");
		return "del";
	}
	//閻€劍鍩涙穱顔芥暭瀹告彃褰傜敮鍐畱閸熷棗鎼ф穱鈩冧紖
	@Action(value = "publishedUpdate", results = { @Result(name = "publishedUpdate", location = "/WEB-INF/mall/goods/publishedUpdate.jsp") })
	public String publishedUpdate(){
		List<Category> categoryList = categoryService.findAll("Category");
		request.setAttribute("categoryList", categoryList);
		goods = goodsService.findById(Goods.class, goods.getId());
		return "publishedUpdate";
	}
	//閺囧瓨鏌婇悽銊﹀煕缂傛牞绶崥搴ｆ畱閸熷棗鎼ф穱鈩冧紖
	@Action(value = "update", interceptorRefs = {
			@InterceptorRef(value = "fileUploadStack", params = { "allowedTypes",
					"image/bmp,image/png,image/gif,image/pjpeg,image/jpg", "maximumSize", "10485760" }),
			@InterceptorRef("defaultStack") }, results = { @Result(name = "publishedGoods", type = "chain", params = {
					"namespace", "/goods", "actionName", "publishedGoods" }) })
	public String update() {
		@SuppressWarnings("deprecation")
		String root = request.getRealPath("/upload");
		goods.setIsRecommend("0");
		goods.setIsChecked("0");
		goods.setMember((Member) session.getAttribute("loginMember"));
		if (null != file)
			try {
				InputStream is = new FileInputStream(file);
				// 瀵版鍩岄崶鍓у娣囨繂鐡ㄩ惃鍕秴缂冿拷閺嶈宓乺oot閺夈儱绶遍崚鏉挎禈閻楀洣绻氱�妯兼畱鐠侯垰绶為崷鈺皁mcat娑撳娈戠拠銉ヤ紣缁嬪鍣�root-閺傚洣娆㈢捄顖氱窞閸氾拷  fileFileName閺傚洣娆㈤崥锟�
				String prefix = String.valueOf(new Date().getTime());
				File destFile = new File(root, prefix + fileFileName);
				String path = "/SHTP/upload/" + prefix + fileFileName;
				// 閹跺﹤娴橀悧鍥у晸閸忋儱鍩屾稉濠囨桨鐠佸墽鐤嗛惃鍕熅瀵板嫰鍣�
				OutputStream os = new FileOutputStream(destFile);
				byte[] buffer = new byte[1024];
				int length = 0;
				while ((length = is.read(buffer)) > 0) {
					os.write(buffer, 0, length);
				}
				is.close();
				os.close();
				goods.setImg(path);				
			} catch (Exception e) {
				e.printStackTrace();
			}
		goodsService.update(goods);
		setMessage("success");
		return "publishedGoods";
	}

	
	//瀹歌尪鍠樻稊鏉挎櫌閸濓拷
	@Action(value = "myGoods", results = { @Result(name = "myGoods", location = "/WEB-INF/mall/goods/myGoods.jsp") })
	public String myGoods(){
		Member mem = (Member) session.getAttribute("loginMember");
		Member member = memberService.findById(Member.class, mem.getId());		
		Set<Orders> myOders = member.getOrders();
		List<Goods> myGoods = new ArrayList<Goods>();
		for(Orders order:myOders ){
			if(!order.getTradingSatuts().equals("0"))
				myGoods.add(order.getGoods());
		}
		request.setAttribute("myGoods", myGoods);
		return "myGoods";
	}
	@Action(value = "addCart", results = { @Result(name = "addCart", type = "json") })
	public String addCart() {
		goods = goodsService.findById(Goods.class, goods.getId());
		Member member = (Member) session.getAttribute("loginMember");
		Orders order = new Orders();
		order.setGoods(goods);
		order.setMember(member);
		order.setOrderTime(new Date());
		order.setTradingSatuts("0");		
		ordersService.save(order);
		setMessage("success");
		return "addCart";
	}
	
}
