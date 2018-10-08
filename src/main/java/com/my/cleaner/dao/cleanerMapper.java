package com.my.cleaner.dao;

import com.my.cleaner.vo.Cleaner;

public interface cleanerMapper {
	public int insertCleaner(Cleaner cleaner);
	public Cleaner selectOneCleaner(Cleaner cleaner);
}
