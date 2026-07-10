<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Medicine Details - Pharmacy Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        .nav {
            background-color: #3498db;
            padding: 15px;
            margin: -20px -20px 20px -20px;
            border-radius: 8px 8px 0 0;
        }
        .nav a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            margin-right: 10px;
            border-radius: 4px;
            display: inline-block;
        }
        .nav a:hover {
            background-color: #2980b9;
        }
        .detail-section {
            margin-bottom: 30px;
        }
        .detail-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            padding: 12px 0;
            border-bottom: 1px solid #ecf0f1;
        }
        .detail-label {
            font-weight: bold;
            color: #34495e;
        }
        .detail-value {
            color: #2c3e50;
        }
        .stock-low {
            color: #e74c3c;
            font-weight: bold;
        }
        .stock-ok {
            color: #27ae60;
        }
        .btn {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            display: inline-block;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .btn-secondary {
            background-color: #95a5a6;
        }
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
        .message-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="nav">
            <a href="<s:url action='dashboard'/>">Dashboard</a>
            <a href="<s:url action='prescription-list'/>">Prescriptions</a>
            <a href="<s:url action='order-list'/>">Orders</a>
            <a href="<s:url action='medicine-list'/>">Medicines</a>
        </div>

        <h1>Medicine Details</h1>

        <s:if test="hasActionErrors()">
            <div class="message-error">
                <s:actionerror/>
            </div>
        </s:if>

        <div class="detail-section">
            <div class="detail-row">
                <div class="detail-label">ID:</div>
                <div class="detail-value"><s:property value="medicine.id"/></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Name:</div>
                <div class="detail-value"><s:property value="medicine.name"/></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Description:</div>
                <div class="detail-value"><s:property value="medicine.description"/></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Price:</div>
                <div class="detail-value">$<s:property value="medicine.price"/></div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Stock:</div>
                <div class="detail-value">
                    <span class="<s:if test='medicine.stockQuantity < 50'>stock-low</s:if><s:else>stock-ok</s:else>">
                        <s:property value="medicine.stockQuantity"/>
                    </span>
                </div>
            </div>
            <div class="detail-row">
                <div class="detail-label">Manufacturer:</div>
                <div class="detail-value"><s:property value="medicine.manufacturer"/></div>
            </div>
        </div>

        <div>
            <a href="<s:url action='medicine-list'/>" class="btn btn-secondary">Back to Medicines</a>
        </div>
    </div>
</body>
</html>
