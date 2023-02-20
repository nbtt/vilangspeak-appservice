export function createTransformerEnum<T>(enumType: T) {
    return {
        from(value: number): T {
            return Object.values(enumType)[value];
        },
        to(value: T): number {
            return Object.values(enumType).indexOf(value);
        },
    }
}

export function getCurrentNumericDate(): number {
    return Math.floor(Date.now() / 1000);
}

export function getDateFromNumericDate(numericDate: number): Date {
    return new Date(numericDate * 1000);
}