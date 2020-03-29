package com.qau.service;

import com.qau.dao.DepartmentMapper;
import com.qau.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        //查出的所有部门信息
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
