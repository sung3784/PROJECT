package com.my.cleaner;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.cleaner.dao.wantedCustomerMapper;
import com.my.cleaner.vo.wantedCustomer;

@Repository
public class repo extends Thread {
	
	@Autowired
	SqlSession session;
	
	
	
	
	
	
	
/*	@Override
	public void run() {
		updateDB();
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/







	public void updateDB() {
		System.out.println("되고있니????");
		String date=null;
		Date date1=null;
		wantedCustomerMapper mapper=session.getMapper(wantedCustomerMapper.class);
		List<wantedCustomer> list= null;
		list=mapper.selectAllWC();
		int result=0;
		date1=new Date(System.currentTimeMillis());
		//년도에 -100하고18 월에 +1하고 7
		
		
		
		
		for(int i=0;i<list.size();i++) {
		date=list.get(i).getWantedTime();
		
		String[] a=null;
		a=date.split("-");
		int year=0; int month=0; int dates=0; int hour=0;
		year=Integer.valueOf(a[0].substring(2, 4));
		month=Integer.valueOf(a[1]);
		dates=Integer.valueOf(a[2].substring(0, 2));
		hour=list.get(i).getSpecificTime();
		
		if(year<=(date1.getYear()-100)) {
			
			if(month<=(date1.getMonth()+1)) {
				
				if(dates<=(date1.getDate())) {
					if(dates<(date1.getDate())) {
						mapper.deleteWantedCustomer(list.get(i).getSeqwc());
					}
					if(date1.getHours()>(hour-2)) {
					mapper.deleteWantedCustomer(list.get(i).getSeqwc());
					}
				}
				
				
			}
		
			
		}
		//1번쨰 2번째 년도 월은 잘 찍히고 근데 3번째꺼는 날짜와 시간이 찍히니까 앞에 날짜만 나오게끔 하고.
		
			
		}	
	}

}
