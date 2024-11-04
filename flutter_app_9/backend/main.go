package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)

// Продукт
type Item struct {
	ID          int    `json:"id"`
	ImageUrl    string `json:"imageUrl"`
	Price       int    `json:"price"`
	Brand       string `json:"brand"`
	Title       string `json:"title"`
	Description string `json:"description"`
}

// Продукты
var products = []Item{
	{ID: 1, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/d14/100500_800_140cd750bba9870f18aada2478b24840a/v3psvqegwnvsxxzjqd0b3ynbe9895cd2.jpg", Price: 115990, Brand: "Apple", Title: "Apple iPhone 16 dual-SIM 128 ГБ, ультрамарин", Description: "Смартфон от Apple с 128 ГБ памяти"},
	{ID: 2, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/683/100500_800_140cd750bba9870f18aada2478b24840a/mdrt1dye5g9s8oosylyd9jzxfv68grjb.jpg", Price: 135990, Brand: "Apple", Title: "Apple iPhone 16 Pro 256 ГБ dual-SIM, розовый", Description: "Флагманский смартфон Apple с 256 ГБ памяти"},
	{ID: 3, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/687/100500_800_140cd750bba9870f18aada2478b24840a/bar79xbho0dww32wzrbj79246qnm8eqv.jpg", Price: 47990, Brand: "Apple", Title: "Apple Watch Series 9, серебристый алюминий", Description: "Умные часы Apple с GPS и 45мм экраном"},
	{ID: 4, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/ac7/100500_800_140cd750bba9870f18aada2478b24840a/ac7fa7156fc033f1b5fa47e541716d7e.jpeg", Price: 249990, Brand: "Apple", Title: "Apple MacBook Pro 14\" M2, 16 ГБ, 512 ГБ SSD", Description: "Ноутбук Apple с процессором M2 и Retina дисплеем"},
	{ID: 5, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/d76/100500_800_140cd750bba9870f18aada2478b24840a/d7687c4047344a6ebd92a158b08ea272.jpg", Price: 89990, Brand: "Apple", Title: "Apple iPad Pro 11\", Wi-Fi, 128 ГБ, серый", Description: "Планшет Apple с процессором M1 и поддержкой Apple Pencil"},
	{ID: 6, ImageUrl: "https://img.mvideo.ru/Big/30067950bb2.jpg", Price: 114990, Brand: "Samsung", Title: "Samsung Galaxy Z Flip5, 256 ГБ, кремовый", Description: "Смартфон Samsung с гибким экраном и 256 ГБ памяти"},
	{ID: 7, ImageUrl: "https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/01ce578db862c3f0e0f1f6e0d42f68c2/f85b56cc2544cd50ed9135fc975507050fae7af62124438363941fea09f41826.jpg.webp", Price: 139990, Brand: "Samsung", Title: "Samsung Galaxy S23 Ultra, 512 ГБ, зеленый", Description: "Флагманский смартфон Samsung с 512 ГБ памяти и камерой 200 МП"},
	{ID: 8, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/683/100500_800_140cd750bba9870f18aada2478b24840a/mdrt1dye5g9s8oosylyd9jzxfv68grjb.jpg", Price: 155990, Brand: "Apple", Title: "Apple iPhone 16 Pro 1024 ГБ dual-SIM, розовый", Description: "Флагманский смартфон Apple с 1024 ГБ памяти"},
	{ID: 9, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/687/100500_800_140cd750bba9870f18aada2478b24840a/bar79xbho0dww32wzrbj79246qnm8eqv.jpg", Price: 47990, Brand: "Apple", Title: "Apple Watch Series 9, серебристый алюминий", Description: "Умные часы Apple с GPS и 45мм экраном"},
	{ID: 10, ImageUrl: "https://static.re-store.ru/upload/resize_cache/iblock/ac7/100500_800_140cd750bba9870f18aada2478b24840a/ac7fa7156fc033f1b5fa47e541716d7e.jpeg", Price: 249990, Brand: "Apple", Title: "Apple MacBook Pro 14\" M2, 16 ГБ, 512 ГБ SSD", Description: "Ноутбук Apple с процессором M2 и Retina дисплеем"},
}

// Все продукты
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(products)
}

// Создание продукта
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Item
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	newID := 1
	if len(products) > 0 {
		newID = products[len(products)-1].ID + 1
	}
	newProduct.ID = newID
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

// Получение продукта
func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	idStr := r.URL.Path[len("/products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid product ID", http.StatusBadRequest)
		return
	}

	for _, product := range products {
		if product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(product)
			return
		}
	}

	http.Error(w, "Product not found", http.StatusNotFound)
}

// Удаление продукта
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	idStr := r.URL.Path[len("/products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid product ID", http.StatusBadRequest)
		return
	}

	for i, product := range products {
		if product.ID == id {
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent)
			return
		}
	}

	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновление продукта
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	idStr := r.URL.Path[len("/products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid product ID", http.StatusBadRequest)
		return
	}

	var updatedProduct Item
	if err := json.NewDecoder(r.Body).Decode(&updatedProduct); err != nil {
		http.Error(w, "Invalid JSON format", http.StatusBadRequest)
		return
	}

	for i, product := range products {
		if product.ID == id {
			products[i].ImageUrl = updatedProduct.ImageUrl
			products[i].Brand = updatedProduct.Brand
			products[i].Title = updatedProduct.Title
			products[i].Description = updatedProduct.Description
			products[i].Price = updatedProduct.Price

			w.Header().Set("Content-Type", "application/json")
			w.WriteHeader(http.StatusOK)
			if err := json.NewEncoder(w).Encode(products[i]); err != nil {
				http.Error(w, "Failed to encode response", http.StatusInternalServerError)
			}
			return
		}
	}

	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)
	http.HandleFunc("/products/create", createProductHandler)
	http.HandleFunc("/products/", getProductByIDHandler)
	http.HandleFunc("/products/update/", updateProductHandler)
	http.HandleFunc("/products/delete/", deleteProductHandler)

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", nil)
}
