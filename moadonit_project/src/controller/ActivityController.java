package controller;

import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Activity;
import model.ActivityType;
import model.Pupil;
import model.PupilActivity;
import model.PupilActivityPK;
import model.RegSource;
import model.RegToMoadonit;
import model.Staff;
import model.User;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

import util.DAOUtil;
import dao.ActivityDAO;
import dao.GeneralDAO;
import dao.PupilActivityDAO;

@WebServlet("/ActivityController")
public class ActivityController extends HttpServlet implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	MyConnection con = null;
	JSONArray jsonArry;
	ActivityDAO actDOA;
	PupilActivityDAO pupilActDAO;
	List<PupilActivity> listPupilActivity;
	List<Activity> listAct;
	JSONObject resultToClient = new JSONObject();
	GeneralDAO generalDAO;
	/**
	 * 
	 */
	public ActivityController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		checkConnection(req, resp);
		this.actDOA = new ActivityDAO(con);
		generalDAO = new GeneralDAO(con);
		String action = req.getParameter("action");
		String jsonResponse = "";
		this.jsonArry = new JSONArray();
		try {
			if (action.equals("getCourses")) {
				listAct = getCourses(req, resp);

				if (!listAct.isEmpty()) {
					getJsonCourses(jsonArry); // get courses
					if (!jsonArry.isEmpty()) {

						jsonResponse = jsonArry.toJSONString();
						jsonResponse = "{\"page\":1,\"total\":\"1\",\"records\":"
								+ jsonArry.size()
								+ ",\"rows\":"
								+ jsonResponse
								+ "}";

						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resp.getWriter().print(jsonResponse);
					} else {
						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resultToClient.put("msg", 0);
						resultToClient.put("result", "לא נמצאו נתונים");
						resp.getWriter().print(resultToClient);
					}
				} else {
					resp.setContentType("application/json");
					resp.setCharacterEncoding("UTF-8");
					resultToClient.put("msg", 0);
					resultToClient.put("result", "לא נמצאו נתונים");
					resp.getWriter().print(resultToClient);
				}
			}
			if (action.equals("getPupilInCourse")) {

				listPupilActivity = getPupilInCourse(req, resp);

				if (!listPupilActivity.isEmpty()) {
					jsonArry = getJsonPupilActivities(listPupilActivity);
					if (!jsonArry.isEmpty()) {

						jsonResponse = jsonArry.toJSONString();
						jsonResponse = "{\"page\":1,\"total\":\"1\",\"records\":"
								+ jsonArry.size()
								+ ",\"rows\":"
								+ jsonResponse
								+ "}";

						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resp.getWriter().print(jsonResponse);

					} else {
						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resultToClient.put("msg", 0);
						resultToClient.put("result", "לא נמצאו נתונים");
						resp.getWriter().print(resultToClient);
					}
				} else {
					resp.setContentType("application/json");
					resp.setCharacterEncoding("UTF-8");
					resultToClient.put("msg", 0);
					resultToClient.put("result", "לא נמצאו נתונים");
					resp.getWriter().print(resultToClient);
				}

			} else if (action.equals("getCurrentYearEndDate")) {
				Date d = this.actDOA.getCurrentYearEndDate();
				if (d != null) {
					resp.setContentType("application/json");
					resp.setCharacterEncoding("UTF-8");
					resultToClient.put("msg", 1);
					resultToClient.put("result", d.getTime());
					resp.getWriter().print(resultToClient);
				} else {
					resp.setContentType("application/json");
					resp.setCharacterEncoding("UTF-8");
					resultToClient.put("msg", 0);
					resultToClient.put("result", "לא נמצאו נתונים");
					resp.getWriter().print(resultToClient);
				}
			}
			//getPupilInCourse
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private JSONObject getSatff() {
		// TODO Auto-generated method stub
		List<Staff> list = generalDAO.get_Staff(0);

		String values = " : ;";
		for (int i = 0; i < list.size(); i++) {
			Staff ft = list.get(i);
			values += ft.getStaffID() + ":" + ft.getLastName() + " " + ft.getFirstName() + ";";
		}
		values = values.substring(0, values.length() - 1);
		JSONObject json = new JSONObject();
		json.put("value", values);
		return json;
	}

	private List<PupilActivity> getPupilInCourse(HttpServletRequest req,
			HttpServletResponse resp) {
		// TODO Auto-generated method stub
		int actID = Integer.parseInt(req.getParameter("activityNum"));
		java.sql.Date dateToSearch = req.getParameter("dateToSearch") == null ? null
				: new java.sql.Date(Long.parseLong(req.getParameter(
						"dateToSearch").toString()));
		this.pupilActDAO = new PupilActivityDAO(con);
		List<PupilActivity> list = this.pupilActDAO.getPupilInCourse(actID,
				dateToSearch);

		return list;
	}

	@SuppressWarnings("unchecked")
	protected JSONArray getJsonPupilActivities(List<PupilActivity> list) {

		JSONArray result = new JSONArray();
		// activityNum, activityName, pupilNum, startDate, regDate, endDate,
		// firstName, lastName
		for (PupilActivity pa : list) {

			JSONObject obj = new JSONObject();
			/*
			 * PupilActivity pa = new PupilActivity(); PupilActivityPK pk = new
			 * PupilActivityPK(); pk.setActivityNum(1); pk.setPupilNum(1);
			 * pa.setId(pk);
			 * 
			 * Activity act = new Activity(); ActivityType type = new
			 * ActivityType(); type.setTypeID(resultSet.getInt("activityType"));
			 * act.setTblActivityType(type);
			 * act.setActivityName(resultSet.getString("activityName"));
			 * 
			 * pa.setTblActivity(act);
			 * 
			 * pa.setRegDate(resultSet.getDate("regDate"));
			 * pa.setStartDate(resultSet.getDate("startDate"));
			 * pa.setEndDate(resultSet.getDate("endDate"));
			 * 
			 * Pupil p = new Pupil(); p.setPupilNum(1);
			 * p.setFirstName(resultSet.getString("firstName"));
			 * p.setLastName(resultSet.getString("lastName"));
			 * 
			 * pa.setTblPupil(p);
			 */
			obj.put("activityNum", pa.getTblActivity().getActivityNum());
			obj.put("activityName", pa.getTblActivity().getActivityName());
			obj.put("pupilNum", pa.getTblPupil().getPupilNum());
			obj.put("startDate", pa.getStartDate() == null ? null : pa
					.getStartDate().getTime());
			obj.put("regDate", pa.getRegDate() == null ? null : pa.getRegDate()
					.getTime());
			obj.put("endDate", pa.getEndDate() == null ? null : pa.getEndDate()
					.getTime());
			obj.put("firstName", pa.getTblPupil().getFirstName());
			obj.put("lastName", pa.getTblPupil().getLastName());
			result.add(obj);

		}
		return result;
	}
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		checkConnection(req, resp);
		this.actDOA = new ActivityDAO(con);
		String action = req.getParameter("action");
		String jsonResponse = "";
		this.jsonArry = new JSONArray();
		try {
			if (action.equals("getCourses")){
				String search = req.getParameter("_search");
				
				if (search.equals("true")) {
					//search data
					listAct = searchCourses(req, resp);
				}else{
					
					//load all data
				    listAct  = getCourses(req,resp);
					
				}
				
				if (!listAct.isEmpty()){
					getJsonCourses(jsonArry); // get courses
					if (!jsonArry.isEmpty()) {
						
						jsonResponse = jsonArry.toJSONString();
						jsonResponse = "{\"page\":1,\"total\":\"1\",\"records\":"
								+ jsonArry.size()
								+ ",\"rows\":"
								+ jsonResponse + "}";

						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resp.getWriter().print(jsonResponse);
					}
					else{
						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resultToClient.put("msg", 0);
						resultToClient.put("result", "לא נמצאו נתונים");
						resp.getWriter().print(resultToClient);
					}
				}
				else{
					resp.setContentType("application/json");
					resp.setCharacterEncoding("UTF-8");
					resultToClient.put("msg", 0);
					resultToClient.put("result", "לא נמצאו נתונים");
					resp.getWriter().print(resultToClient);
				}
			}else if (action.equals("insert")) {
				
					insertCourse(req, resp);
					
					resp.setContentType("application/json");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().print(resultToClient);

				
			}else if (action.equals("update")) {
				
				boolean r = updateCourse(req, resp);
				if (r) {
					resultToClient.put("msg", 1);
					resultToClient.put("result", null);
				} else {
					resultToClient.put("msg", 0);
					resultToClient
							.put("result", "שגיאה בשמירת הנתונים");
				}

				resp.setContentType("application/json");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().print(resultToClient);
			}
			else if (action.equals("insertPupilActivity")) {
				
				boolean r = insertPupilActivity(req, resp);
				
				
				resp.setContentType("application/json");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().print(resultToClient);
			}
			else if (action.equals("editPupilInCourse")){
				// 
				boolean r = editPupilInCourse(req, resp);
				resp.setContentType("application/json");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().print(resultToClient);
			}else if(action.equals("deletePupilActivity")){
				
				//
				boolean r = deletePupilActivity(req, resp);
				resp.setContentType("application/json");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().print(resultToClient);
			}
			
			//
		} catch (Exception e) {
			e.printStackTrace();
			resultToClient.put("msg", 0);
			resultToClient
					.put("result", "שגיאה בשמירת הנתונים");
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().print(resultToClient);
			
		}
	}
	
	@SuppressWarnings("unchecked")
	private boolean deletePupilActivity(HttpServletRequest req,
			HttpServletResponse resp) {
		// TODO Auto-generated method stub
		this.pupilActDAO = new PupilActivityDAO(con);
		PupilActivity pa = new PupilActivity();
		pa = (PupilActivity)DAOUtil.getObjectFromJson(req.getParameter("pupilActivity"), pa.getClass());
		boolean r  = this.pupilActDAO.delete(pa);	
		if (r) {
			resultToClient.put("msg", 1);
			resultToClient.put("result", "רשומה נמחקה בהצלחה");
			return true;
		} else {
			resultToClient.put("msg", 0);
			resultToClient.put("result", "שגיאה בשמירת הנתונים");
			return false;
		}
		
		
	}
	
	@SuppressWarnings("unchecked")
	private boolean editPupilInCourse(HttpServletRequest req,
			HttpServletResponse resp) {
		// TODO Auto-generated method stub
		this.pupilActDAO = new PupilActivityDAO(con);
		PupilActivity pa = new PupilActivity();
		if (req.getSession().getAttribute("userid") != null) {
			JSONObject user = (JSONObject) req.getSession()
					.getAttribute("userid");
			User u = new User();
			u = (User) DAOUtil.getObjectFromJson(user.toString(), u.getClass());
			pa = (PupilActivity)DAOUtil.getObjectFromJson(req.getParameter("pupilActivity"), pa.getClass());
			pa.setTblUser(u);
			boolean r  = this.pupilActDAO.update(pa);	
			if (r) {
				resultToClient.put("msg", 1);
				resultToClient.put("result", "רישום נשמר בהצלחה");
			} else {
				resultToClient.put("msg", 0);
				resultToClient
						.put("result", "שגיאה בשמירת הנתונים");
			}
			return true;
		}
		
		return false;
	}
	@SuppressWarnings("unchecked")
	private boolean insertPupilActivity( HttpServletRequest req, HttpServletResponse resp) {
		
		boolean r = false;
		try {
			
			PupilActivity pa;
			String str = req.getParameter("activityData");
			if (req.getSession().getAttribute("userid") != null) {
				JSONObject user = (JSONObject) req.getSession()
						.getAttribute("userid");
				User u = new User();
				u = (User) DAOUtil.getObjectFromJson(user.toString(), u.getClass());

				pa = (PupilActivity) DAOUtil.getObjectFromJson(str, PupilActivity.class);
				pa.setTblUser(u);
				
				r = this.pupilActDAO.insert(pa);	
				if (r) {
					resultToClient.put("msg", 1);
					resultToClient.put("result", "רישום נשמר בהצלחה");
				} else {
					resultToClient.put("msg", 0);
					resultToClient
							.put("result", "שגיאה בשמירת הנתונים");
				}
			}
			else{
				r = false;
			}
			
		} catch (Exception e) {
			r = false;
			resultToClient.put("msg", 0);
			resultToClient.put("result",e.getMessage());
		}
		
		return r;
	}
 	private void insertCourse(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		
		
		
	}
	@SuppressWarnings("unchecked")
	private Boolean updateCourse(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
		// TODO Auto-generated method stub
		Activity act ;
		String activityData = req.getParameter("activityData");
		
		String startTime = req.getParameter("startTime");
		String[] start = startTime.split(":");
		@SuppressWarnings("deprecation")
		java.sql.Time sTime = new Time(Integer.parseInt(start[0]), Integer.parseInt(start[1]), 00);
		
		String endTime = req.getParameter("endTime");
		String[] end = endTime.split(":");
		@SuppressWarnings("deprecation")
		java.sql.Time eTime = new Time(Integer.parseInt(end[0]), Integer.parseInt(end[1]), 00);
		/*String endTime = req.getParameter("endTime");
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
		Date date = format.parse(startTime);*/
		//Time t = new Time();
		
		
		act = (Activity) DAOUtil.getObjectFromJson(activityData, Activity.class);
		act.setStartTime(sTime);
		act.setEndTime(eTime);
		// SHIR- in this point we get both times into act
		//somewhere after here the end date becomes null
		actDOA = new ActivityDAO(con);
		Boolean result = actDOA.updateCourse(act);

		return result;
		
	}
	
	private List<Activity> searchCourses(HttpServletRequest req,
			HttpServletResponse resp) {
		// TODO Auto-generated method stub

		List<Activity> result = new ArrayList<>();
		String week = req.getParameter("weekDay");
		
		week = (week != null && week.trim().equals("")) ? null : week;

		String isRegular = req.getParameter("regularOrPrivate");
		isRegular = (isRegular != null && isRegular.trim().equals("")) ? null : isRegular;
		
		String staffName = req.getParameter("staffName");
		staffName = (staffName != null && staffName.trim().equals("")) ? null : staffName;
		
		//req.getParameter("regularOrPrivate").trim().equals("") ? null : req.getParameter("regularOrPrivate");
		
		result = this.actDOA.searchCoursesByParam(
				// 0, // id
				req.getParameter("activityName"), 
				week, 
				req.getParameter("startTime"), 
				req.getParameter("endTime"),
				staffName, 
				req.getParameter("pricePerMonth") != null ? Float.parseFloat(req.getParameter("pricePerMonth")) : 0,
				req.getParameter("extraPrice") != null ? Float.parseFloat(req.getParameter("extraPrice")) : 0
				,isRegular
				, 0 //no need for category
				, req.getParameter("activityGroup")
				);
		return result;
	}
	
	@SuppressWarnings("unchecked")
	protected JSONObject getJsonActivities(Activity act ) {

//		/activityNum, activityType, activityName, weekDay, startTime, endTime, schoolYear, responsibleStaff, activityNum, pricePerMonth, extraPrice, regularOrPrivate, category
			
				JSONObject obj = new JSONObject();

				obj.put("activityNum", act.getActivityNum());
				obj.put("activityType", act.getTblActivityGroup().getTblActivityType().getTypeID());
				obj.put("activityGroup", act.getTblActivityGroup().getActGroupName());
				obj.put("activityGNum", act.getTblActivityGroup().getActivityGroupNum());
				obj.put("activityName", act.getActivityName());
				obj.put("weekDay", act.getWeekDay());			
				obj.put("startTime", act.getStartTime().toString().substring(0,5));
				obj.put("endTime",act.getEndTime().toString().substring(0,5));
				//obj.put("schoolYear", getRegType(act.getTblRegType5().getTypeNum()));
				String fn = act.getTblStaff().getFirstName() != null ? act.getTblStaff().getFirstName() : "";
				String ln = act.getTblStaff().getLastName() != null ? act.getTblStaff().getLastName() : "";
				obj.put("staffName", ln	+ " " + fn);
				obj.put("staffID", act.getTblStaff().getStaffID());
				return obj;
	}
	
	@SuppressWarnings("unchecked")
	protected void getJsonCourses(JSONArray registrationData) {

//		/ pricePerMonth, extraPrice, regularOrPrivate, category
			for (Activity act : this.listAct) {
				JSONObject obj ;
				obj = getJsonActivities(act);
				
				obj.put("pricePerMonth", act.getTblCourse().getPricePerMonth());
				obj.put("extraPrice", act.getTblCourse().getExtraPrice());
				obj.put("regularOrPrivate", act.getTblCourse().getRegularOrPrivate());
				obj.put("category", act.getTblCourse().getCategory());
				obj.put("pupilCapacity", act.getTblCourse().getPupilCapacity());
				registrationData.add(obj);

			}

		

	}
	
	private List<Activity> getCourses(HttpServletRequest req,
			HttpServletResponse resp) {
		// TODO Auto-generated method stub
		List<Activity> result = new ArrayList<>();
		int actID = Integer.parseInt(req.getParameter("activityNum"));
		result = this.actDOA.selectActivites(actID);
		return result;
	}
	
	protected void checkConnection(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if (session.getAttribute("connection") != null) {
			con = (MyConnection) session.getAttribute("connection");
		} else {
			try {
				con = new MyConnection();

			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			session.setAttribute("connection", con);
		}

	}
}
