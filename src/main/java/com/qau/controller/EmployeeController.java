package com.qau.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qau.model.Employee;
import com.qau.model.Msg;
import com.qau.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    private EmployeeService employeeService;

    @Autowired
    public void setEmployeeService (EmployeeService employeeService) {
        this.employeeService = employeeService;
    }
    /**
     * 查询员工数据 分页查询
     * @return
     * @ResponseBody需要jackson包
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmplsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细信息,包括我们查询出来的信息,可以传入连续显示的页数 这里是5
        PageInfo page = new PageInfo(emps,5);
        return Msg.succcess().add("pageInfo",page);
    }
    //@RequestMapping("/emps")
    public String getEmployees(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
            Model model){
        //这不是一个分页查询
        //引入PageHelper插件
        //在查询之前只需要调用,传入页码,每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细信息,包括我们查询出来的信息,可以传入连续显示的页数 这里是5
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }

    /**
     *
     * 员工保存
     * @return
     */
    @RequestMapping(value = "emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<String, Object>();
            //校验失败 应该返回失败 在模态框中返回校验失败的信息
            List<FieldError> errors = (List<FieldError>) result.getFieldError();
            for(FieldError fieldError:errors){
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误的信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.succcess();
        }

    }
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuse(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式;
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6-16位英文或2-5位中文");
        }
        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.succcess();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.succcess().add("emp",employee);
    }

    //更新保存员工
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.succcess();
    }

    /**
     * 单一批量二合一
     * 批量删除 1-2-3
     * 单个删除 1
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids")String ids) {
        if (ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        } else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.succcess();

    }
}
