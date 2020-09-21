#!/usr/bin/env python
# coding: utf-8

# In[114]:


import mysql.connector


# In[120]:


mydb = mysql.connector.connect(host='localhost', user='root', passwd='root', database='hr_db')


# In[121]:


myc = mydb.cursor()


# In[124]:


myc.execute('select first_name, last_name, department_name from employees join departments where employees.department_id = departments.department_id')
result = myc.fetchall()
for i in result:
    print(i)


# In[125]:


myc.execute('select first_name, last_name, job_title from employees join jobs where employees.job_id = jobs.job_id')
result = myc.fetchall()
for i in result:
    print(i)

