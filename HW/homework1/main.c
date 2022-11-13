#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"

#define MAX_INPUT_LINE_SIZE 256 + 1
#define SUCCES 0
#define NULL_POINTER -1
#define ALOCARE_ESUATA -2
#define EROARE -3
#define INDEX_GRESIT -4
#define PPRIMUL_TIP 1
#define AL_DOILEA_TIP 2
#define AL_TREILEA_TIP 3

// Adauga la sfarsitul array-ului
int add_last(void **arr, int *len, data_structure *data) {
	
	if(!arr) return NULL_POINTER;
	
	// Daca e primul element in array 
	if(!(*arr)){
		*arr = calloc(1, sizeof(head) + data->header->len);
		if(!(*arr)) return ALOCARE_ESUATA;

		memcpy(*arr, data->header, sizeof(head));
		memcpy((char*)*arr + sizeof(head), data->data, data->header->len);
		*len = sizeof(head) + data->header->len;
		return SUCCES;
	}

	// Daca nu e primul
	void* tmp_arr;
	tmp_arr = realloc(*arr, *len + sizeof(head) + data->header->len);
	if(!tmp_arr) {
		return ALOCARE_ESUATA;
	} else {
		*arr = tmp_arr;
	}

	memcpy((char*)*arr + *len, data->header, sizeof(head));
	memcpy((char*)*arr + *len + sizeof(head), data->data, data->header->len);
	*len += sizeof(head) + data->header->len;

	return SUCCES;
}

// Adauga la posizita index in array
int add_at(void **arr, int *len, data_structure *data, int index) {
	char* tmp = *arr;
	int tmp_len = 0;
	int crr_index = 0;

	if(!arr) return NULL_POINTER;
	if(index < 0) return INDEX_GRESIT;
	
	// Daca array-ul e gol, nu conteaza indexul
	if(!(*arr)){
		*arr = calloc(1, sizeof(head) + data->header->len);
		if(!(*arr)) return ALOCARE_ESUATA;

		memcpy(*arr, data->header, sizeof(head));
		memcpy((char*)*arr + sizeof(head), data->data, data->header->len);
		*len = sizeof(head) + data->header->len;
		return SUCCES;
	}

	// Caut index-ul
	while (tmp_len < *len && crr_index != index){
		tmp_len += sizeof(head) + ((head*)(tmp + tmp_len))->len;
		crr_index++;
	}

	// Daca sa ajuns la sfarsit, adaug la sfarsit
	if(tmp_len >= *len) return add_last(arr, len, data);

	// Fac spatiu pentru noul element
	void* tmp_arr;
	tmp_arr = realloc(*arr, *len + sizeof(head) + data->header->len);
	if(!tmp_arr) {
		return ALOCARE_ESUATA;
	} else {
		*arr = tmp_arr;
	}

	// Mut toate elementele de la index spre sfarsit
	memmove((char*)*arr + tmp_len + sizeof(head) + data->header->len,
			(char*)*arr + tmp_len,
			*len - tmp_len);

	memcpy((char*)*arr + tmp_len, data->header, sizeof(head));
	memcpy((char*)*arr + tmp_len + sizeof(head), data->data, data->header->len);
	*len += sizeof(head) + data->header->len;

	return SUCCES;

}

// Printeaza tip 1
void print_tip_1(void* info){
	printf("Tipul 1\n");
	printf("%s pentru %s\n", (char*)info, ((char*)info) + strlen((char*)info) 
											+ 1 + 2 * sizeof(int8_t));
	printf("%hhd\n", *(int8_t*)(info + strlen((char*)info) + 1));
	printf("%hhd\n\n", *(int8_t*)(info + strlen((char*)info) + 1 
						+ sizeof(int8_t)));
}

// Printeaza tip 2
void print_tip_2(void* info){
	printf("Tipul 2\n");
	printf("%s pentru %s\n", (char*)info, ((char*)info) + strlen((char*)info) 
										+ 1 + sizeof(int16_t) + sizeof(int32_t));
	printf("%d\n", *(int16_t*)(info + strlen((char*)info) + 1));
	printf("%d\n\n", *(int32_t*)(info + strlen((char*)info) 
					+ 1 + sizeof(int16_t)));
}

// Printeaza tip 3
void print_tip_3(void* info){
	printf("Tipul 3\n");
	printf("%s pentru %s\n", (char*)info, (char*)info + strlen((char*)info) 
										+ 1 + sizeof(int32_t) + sizeof(int32_t));
	printf("%d\n", *(int32_t*)(info + strlen((char*)info) + 1));
	printf("%d\n\n", *(int32_t*)(info + strlen((char*)info) 
					+ 1 + sizeof(int32_t)));
}

// Afiseaza ce se afla la index
void find(void *data_block, int len, int index) {
	
	if(!data_block) return;
	if(index < 0) return;

	// Caut cati octeti trebuie omisi
	int tmp_len = 0, crr_index = 0;
	while (tmp_len < len && crr_index != index){
		tmp_len += sizeof(head) + ((head*)(data_block + tmp_len))->len;
		crr_index++;
	}

	// Daca nu sa gasit indexul
	if(tmp_len >= len) return;

	//Afisare in dependenta de tip
	void* tmp = data_block + tmp_len;
	switch (((head*)(tmp))->type)	{
		case PPRIMUL_TIP:
			print_tip_1((tmp + sizeof(head)));
			break;
		case AL_DOILEA_TIP:
			print_tip_2(tmp + sizeof(head));
			break;
		case AL_TREILEA_TIP:
			print_tip_3(tmp + sizeof(head));
			break;
		default:
			break;
	}

}

// Sterge un element ce se afla la index
int delete_at(void **arr, int *len, int index) {
	if(!arr) return NULL_POINTER;
	if(!(*arr)) return NULL_POINTER;
	if(index < 0) return INDEX_GRESIT;

	int tmp_len = 0, crr_index = 0;

	// Cauta cati octeti trebuie omisi
	while (tmp_len < *len && crr_index != index){
		tmp_len += sizeof(head) + ((head*)(*arr + tmp_len))->len;
		crr_index++;
	}

	if(crr_index != index) return INDEX_GRESIT;

	// Elibereaza memoria si modifica array-ul
	head* h = (head*) (*arr + tmp_len);
	// Salvez lungimea veche si o recalculez
	int old_len = *len;
	*len = *len - sizeof(head) - h->len;
	memmove(*arr+tmp_len, *arr + tmp_len + sizeof(head) + h->len, 
			old_len - tmp_len - sizeof(head) - h->len);
	
	// Realoc memoria
	*arr = realloc(*arr, *len);

	return SUCCES;	
}

// Printeaza array-ul
int print(void* arr, int len){

	char* tmp = arr;
	int tmp_len = 0;

	// Parcurg array-ul
	while (tmp_len < len){
		switch (((head*)(tmp + tmp_len))->type)	{
			case PPRIMUL_TIP:
				print_tip_1(tmp + tmp_len + sizeof(head));
				break;
			case AL_DOILEA_TIP:
				print_tip_2(tmp + tmp_len + sizeof(head));
				break;
			case AL_TREILEA_TIP:
				print_tip_3(tmp + tmp_len + sizeof(head));
				break;
			default:
				return EROARE;
		}

		tmp_len += sizeof(head) + ((head*)(tmp + tmp_len))->len;
	}

	return SUCCES;
}

// Functie de eliberat memorie
int free_my_arr(void** arr){
	free(*arr);
	return SUCCES;
}

int main() {
	void *arr = NULL;
	int pos, len = 0;
	char *buff = calloc(MAX_INPUT_LINE_SIZE + 1, sizeof(char));
	char *comm = calloc(20, sizeof(char));
	
	while(fgets(buff,MAX_INPUT_LINE_SIZE + 1,stdin) != NULL){

		//Daca e newline, carriage return sau linie goala
        if(buff[strlen(buff) - 1] == '\n') buff[strlen(buff) - 1] = '\0';
        if(buff[strlen(buff) - 1] == '\r') buff[strlen(buff) - 1] = '\0';
		if(*buff == '\0' ) continue;

		sscanf(buff, "%s%n", comm, &pos);
			
		if(!strcmp(comm, "exit")){
			free_my_arr(&arr);
			break;
		}

		if(!strcmp(comm, "find")){
			int pos_in_arr;
			sscanf(buff + pos + 1,"%d", &pos_in_arr);
			find(arr, len, pos_in_arr);
			continue;
		}

		if(!strcmp(comm, "insert_at")){
			void* date_pentru_a_fi_salvate;
			int len_data;
			unsigned char type;
			int pos_1, pos_in_arr;
			sscanf(buff + pos + 1,"%d%hhd%n", &pos_in_arr,&type, &pos_1);
			pos += pos_1 + 1;

			if(type == PPRIMUL_TIP){
				char* buffer = calloc(MAX_INPUT_LINE_SIZE, sizeof(char));
				char* care_dedica;
				char* carui_i_se_dedica;
				int8_t x, y;

				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);
				pos += pos_1 + 1;

				care_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(care_dedica, buffer, strlen(buffer) + 1);

				sscanf(buff + pos + 1, "%hhd %hhd %n", &x, &y, &pos_1);
				pos += pos_1;
				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);

				carui_i_se_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(carui_i_se_dedica, buffer, strlen(buffer) + 1);
				
				len_data = strlen(care_dedica) + strlen(carui_i_se_dedica) 
							+ sizeof(int8_t) * 2 + 2;
				date_pentru_a_fi_salvate = calloc(len_data, sizeof(char));
				memcpy(date_pentru_a_fi_salvate, care_dedica, 
						strlen(care_dedica) + 1);
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1, &x, 
						sizeof(int8_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int8_t), 
						&y, sizeof(int8_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + 2*sizeof(int8_t), 
						carui_i_se_dedica, strlen(carui_i_se_dedica) + 1);

				free(care_dedica);
				free(carui_i_se_dedica);
				free(buffer);
			}
			
			if (type == AL_DOILEA_TIP){
				char* buffer = calloc(MAX_INPUT_LINE_SIZE, sizeof(char));
				char* care_dedica;
				char* carui_i_se_dedica;
				int16_t x;
				int32_t y;

				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);
				pos += pos_1 + 1;

				care_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(care_dedica, buffer, strlen(buffer) + 1);

				sscanf(buff + pos + 1, "%hd %d %n", &x, &y, &pos_1);
				pos += pos_1;
				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);

				carui_i_se_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(carui_i_se_dedica, buffer, strlen(buffer) + 1);
				
				len_data = strlen(care_dedica) + strlen(carui_i_se_dedica) 
				+ 2 + sizeof(int16_t) + sizeof(int32_t);
				date_pentru_a_fi_salvate = calloc(len_data, sizeof(char));
				memcpy(date_pentru_a_fi_salvate, care_dedica, 
				strlen(care_dedica) + 1);
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1, &x, 
				sizeof(int16_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int16_t), 
				&y, sizeof(int32_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int16_t) + sizeof(int32_t), 
				carui_i_se_dedica, strlen(carui_i_se_dedica) + 1);
				
				
				free(buffer);
				free(care_dedica);
				free(carui_i_se_dedica);
			}

			if(type == AL_TREILEA_TIP){
				char* buffer = calloc(MAX_INPUT_LINE_SIZE, sizeof(char));
				char* care_dedica;
				char* carui_i_se_dedica;
				int32_t x;
				int32_t y;

				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);
				pos += pos_1 + 1;

				care_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(care_dedica, buffer, strlen(buffer) + 1);

				sscanf(buff + pos + 1, "%d %d %n", &x, &y, &pos_1);
				pos += pos_1;
				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);

				carui_i_se_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(carui_i_se_dedica, buffer, strlen(buffer) + 1);
				
				len_data = strlen(care_dedica) + strlen(carui_i_se_dedica) + 2 
						+ sizeof(int32_t) + sizeof(int32_t);
				date_pentru_a_fi_salvate = calloc(len_data, sizeof(char));
				memcpy(date_pentru_a_fi_salvate, care_dedica, 
						strlen(care_dedica) + 1);
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1, &x, 
						sizeof(int32_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int32_t), 
						&y, sizeof(int32_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int32_t) + sizeof(int32_t), 
						carui_i_se_dedica, strlen(carui_i_se_dedica) + 1);
				
				
				free(care_dedica);
				free(carui_i_se_dedica);
				free(buffer);
			}
			


			data_structure* data = calloc(1, sizeof(data_structure));
			data->header = calloc(1, sizeof(head));
			data->data = date_pentru_a_fi_salvate;
			data->header->type = type;
			data->header->len = len_data;
			add_at(&arr,&len, data, pos_in_arr);
			free(date_pentru_a_fi_salvate);
			free(data->header);
			free(data);

			continue;
		}

		if(!strcmp(comm, "insert")){
			void* date_pentru_a_fi_salvate;
			int len_data;
			unsigned char type;
			int pos_1;
			sscanf(buff + pos + 1,"%hhd%n", &type, &pos_1);
			pos += pos_1 + 1;

			if(type == PPRIMUL_TIP){
				char* buffer = calloc(MAX_INPUT_LINE_SIZE, sizeof(char));
				char* care_dedica;
				char* carui_i_se_dedica;
				int8_t x, y;

				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);
				pos += pos_1 + 1;

				care_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(care_dedica, buffer, strlen(buffer) + 1);

				sscanf(buff + pos + 1, "%hhd %hhd %n", &x, &y, &pos_1);
				pos += pos_1;
				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);

				carui_i_se_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(carui_i_se_dedica, buffer, strlen(buffer) + 1);

				len_data = strlen(care_dedica) + strlen(carui_i_se_dedica) 
							+ sizeof(int8_t) * 2 + 2;
				date_pentru_a_fi_salvate = calloc(len_data, sizeof(char));
				memcpy(date_pentru_a_fi_salvate, care_dedica, 
						strlen(care_dedica) + 1);
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1, 
						&x, sizeof(int8_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int8_t), 
						&y, sizeof(int8_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + 2*sizeof(int8_t), 
						carui_i_se_dedica, strlen(carui_i_se_dedica) + 1);
				

				free(buffer);
				free(care_dedica);
				free(carui_i_se_dedica);
			}
			
			if (type == AL_DOILEA_TIP){
				char* buffer = calloc(MAX_INPUT_LINE_SIZE, sizeof(char));
				char* care_dedica;
				char* carui_i_se_dedica;
				int16_t x;
				int32_t y;

				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);
				pos += pos_1 + 1;

				care_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(care_dedica, buffer, strlen(buffer) + 1);

				sscanf(buff + pos + 1, "%hd %d %n", &x, &y, &pos_1);
				pos += pos_1;
				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);

				carui_i_se_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(carui_i_se_dedica, buffer, strlen(buffer) + 1);

				len_data = strlen(care_dedica) + strlen(carui_i_se_dedica) + 2 
							+ sizeof(int16_t) + sizeof(int32_t);
				date_pentru_a_fi_salvate = calloc(len_data, sizeof(char));
				memcpy(date_pentru_a_fi_salvate, care_dedica, 
						strlen(care_dedica) + 1);
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1,
						&x, sizeof(int16_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int16_t), 
						&y, sizeof(int32_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int16_t) + sizeof(int32_t), 
						carui_i_se_dedica, strlen(carui_i_se_dedica) + 1);
				

				free(buffer);
				free(care_dedica);
				free(carui_i_se_dedica);
			}

			if(type == AL_TREILEA_TIP){
				char* buffer = calloc(MAX_INPUT_LINE_SIZE, sizeof(char));
				char* care_dedica;
				char* carui_i_se_dedica;
				int32_t x;
				int32_t y;

				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);
				pos += pos_1 + 1;

				care_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(care_dedica, buffer, strlen(buffer) + 1);

				sscanf(buff + pos + 1, "%d %d %n", &x, &y, &pos_1);
				pos += pos_1;
				sscanf(buff + pos + 1, "%s%n", buffer, &pos_1);

				carui_i_se_dedica = calloc(strlen(buffer) + 1, sizeof(char));
				memcpy(carui_i_se_dedica, buffer, strlen(buffer) + 1);

				len_data = strlen(care_dedica) + strlen(carui_i_se_dedica) + 2 
							+ sizeof(int32_t) + sizeof(int32_t);
				date_pentru_a_fi_salvate = calloc(len_data, sizeof(char));
				memcpy(date_pentru_a_fi_salvate, care_dedica, 
						strlen(care_dedica) + 1);
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1, 
						&x, sizeof(int32_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int32_t), 
						&y, sizeof(int32_t));
				memcpy(date_pentru_a_fi_salvate + strlen(care_dedica) + 1 + sizeof(int32_t) + sizeof(int32_t), 
						carui_i_se_dedica, strlen(carui_i_se_dedica) + 1);
				

				free(care_dedica);
				free(carui_i_se_dedica);
				free(buffer);
			}
			


			data_structure* data = calloc(1, sizeof(data_structure));
			data->header = calloc(1, sizeof(head));
			data->data = date_pentru_a_fi_salvate;
			data->header->type = type;
			data->header->len = len_data;
			add_last(&arr, &len, data);
			free(date_pentru_a_fi_salvate);
			free(data->header);
			free(data);

			continue;
		}

		if(!strcmp(comm, "print")){
			print(arr, len);
			continue;
		}

		if(!strcmp(comm, "delete_at")){
			int pos_in_arr;
			sscanf(buff + pos + 1,"%d", &pos_in_arr);
			delete_at(&arr, &len, pos_in_arr);
			continue;
		}

	}

	free(buff);
	free(comm);

	return 0;
}
