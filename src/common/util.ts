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