/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.schedule;

import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/schedule")
public class ScheduleCtrl {
	@Resource(name="scheduleDAO")
	private ScheduleDAO dao;
	
	@RequestMapping(value = "/main.do")
	public String main(HttpServletRequest request, ModelMap model) throws Exception {
		HashMap<String, Object> params = getParams(request);
		String year = (String) params.get("year");
		Calendar cal = Calendar.getInstance();
		if(year==null){
			year = String.valueOf(cal.get(Calendar.YEAR));
		}
		params.put("year", year);
		
		String month = (String) params.get("month");
		if(month==null){
			month = String.valueOf(cal.get(Calendar.MONTH)+1);
		}
		params.put("month", month);
		
		cal.set(Integer.valueOf(year), Integer.valueOf(month)-1, 1);
		int i=1;
		int j = cal.get(Calendar.DAY_OF_WEEK);
		int k = cal.getActualMaximum(Calendar.DATE);
		int day= 0;
		HashMap<String, Object> weeks = new HashMap<>();
		for(int y=1;y<=6;y++){
			for(int x=1;x<=7;x++){
				day = (i-j)+1;
				if(1<=day&&day<=k){
					weeks.put(y+""+x, day+"");
				}
				i++;
			}
		}
		params.put("weeks", weeks);
		model.addAttribute("memo",dao.select(params));
		model.addAttribute("params",params);
		return "schedule/schedule";
	}

	public static HashMap<String, Object> getParams(HttpServletRequest request) {
		Enumeration enumber = request.getParameterNames();
		HashMap<String, Object> params = new HashMap<String, Object>();

		while (enumber.hasMoreElements()) {
			String key = enumber.nextElement().toString();
			String value = request.getParameter(key);

			System.out.println("log.enumber.hasMoreElements key :"  +  key + " : " + value);

			params.put(key, value);  
		}
		return params;
	}
}
